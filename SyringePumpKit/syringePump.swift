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
        super.init()
        self.serialPort.delegate = self
    }
        
    
    func write(command: String){
        let sendCommand = "\(command)\n\r"
        self.serialPort.send(sendCommand.data(using: .ascii)!) // someData is an NSData object
    }
    
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        let string = String(data: data, encoding: .ascii)
        if string == "\u{02}"{
//            print("got \(tempStr)")
            tempStr = ""
        } else if string == "\u{03}" {
           print("Recieved: \(tempStr) from pump")
        } else {
            tempStr += string!
        }
    }
    
    func close(){
        self.serialPort.close()
    }
    
}

// MARK: - Functions

extension syringePump {
    /**
     Set inside diameter of syringe in mm. Set is only valid when the Pumping Program is not operating. Setting the syringe diameter also sets the units for “Volume to be Dispensed” and “Volume Dispensed”.
     Valid syringe diameters are from 0.1 mm to 50.0 mm.
    
    */
    func setDiameter(of diameter: String){
        write(command: "dia\(diameter)")
    }
    
    func readDiameter() -> String {
        write(command: "dia")
        return tempStr
    }
    
    func setRate(rate: String, units: String){
        write(command: "funrat")
        write(command: "rat\(rate)\(units)")
    }
    
    func readRate() -> String{
        write(command: "funrat")
        write(command: "rat")
        return tempStr
    }
    
    enum PumpDirection {
        case withdraw
        case infuse
    }
    
    func setDirection(of direction: PumpDirection){
        switch direction {
        case .infuse: self.write(command: "dirinf")
        case .withdraw: self.write(command: "dirwdr")
        }
    }
    
    func run(){
        write(command: "run")
    }
    
    func pause(){
        write(command: "stp")
    }
    
    func stop(){
        write(command: "funstp")
    }
    
    func getVolDispensed() -> String {
        write(command: "dis")
        return tempStr
    }
}
