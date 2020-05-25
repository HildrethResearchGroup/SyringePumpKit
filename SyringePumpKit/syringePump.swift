import Foundation
import ORSSerial

class syringePump: NSObject, ORSSerialPortDelegate {
    
    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        print("serial port removed from sys")
    }
    
    
    
    let serialPort: ORSSerialPort
    var tempStr = ""
   
    
    init(port: String) {
        self.serialPort = ORSSerialPort(path: port)!
        self.serialPort.baudRate = 9600
        self.serialPort.numberOfStopBits = 1
        self.serialPort.parity = .none
        self.serialPort.open()
    }
        
    func info(){
        print("is open: \(serialPort.isOpen)")
        print("Parity: \(serialPort.parity)")
        print("Name: \(serialPort.name)")
        print("Path: \(serialPort.path)")
        print("Description: \(serialPort.description)")
        self.serialPort.delegate = self

    }
    
    func go(command: String){
        let sendCommand = "\(command)\n\r"
        self.serialPort.send(sendCommand.data(using: .ascii)!) // someData is an NSData object
    }
        
    func close(){

        self.serialPort.close()
    }
    
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        let string = String(data: data, encoding: .ascii)
        if string == "\u{03}"{
            print("got \(tempStr)")
            tempStr = ""
        } else {
            tempStr += string!
        }
    }
    
}
