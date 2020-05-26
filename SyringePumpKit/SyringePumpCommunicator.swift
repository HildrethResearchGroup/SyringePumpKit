//
//  syringePumpCommunicator.swift
//  SyringePumpKit
//
//  Created by Steven DiGregorio on 5/25/20.
//  Copyright © 2020 Steven DiGregorio. All rights reserved.
//

import Foundation
import ORSSerial

class SyringePumpCommunicator: NSObject, ORSSerialPortDelegate {
    
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
    
    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        print("serial port removed from sys")
    }
        
    // Writes commands to the pump
    func write(command: String){
        // waiting a short time between sending commands
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let sendCommand = "\(command)\n\r"
            self.serialPort.send(sendCommand.data(using: .ascii)!) // someData is an NSData object
        }
    }
    
    // Reads commands from the pump
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
