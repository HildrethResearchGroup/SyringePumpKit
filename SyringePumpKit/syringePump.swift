import Foundation
import ORSSerial

class syringePump {
    
    let serialPort: ORSSerialPort
    
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
    }
    
    func go(command: String){
        let sendCommand = "\(command)\n\r"
        self.serialPort.send(sendCommand.data(using: .ascii)!) // someData is an NSData object
        }
        
    func close(){
        self.serialPort.close()
    }
    
}
