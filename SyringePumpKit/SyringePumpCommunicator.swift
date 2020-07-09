//
//  syringePumpCommunicator.swift
//  SyringePumpKit
//
//  Created by Steven DiGregorio on 5/25/20.
//  Copyright © 2020 Steven DiGregorio. All rights reserved.
//

import Foundation
import SwiftSerial

class SyringePumpCommunicator: NSObject {
    
    let serialPort: SerialPort
    var tempStr = ""
    
    init(portName: String) {
        self.serialPort = SerialPort(path: portName)
        
        do {
        print("Attempting to open port: \(portName)")
        try serialPort.openPort()
        print("Serial port \(portName) opened successfully.")
        }
        catch {
            serialPort.closePort()
            print("Port Closed")
        }
            
        self.serialPort.setSettings(receiveRate: .baud9600,
                               transmitRate: .baud9600,
                               minimumBytesToRead: 1)
    }
        
    
    // Writes commands to the pump
    func write(command: String){
        
        // waiting a short time between sending commands
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let sendCommand = "\(command)\n\r"
            do {
                try self.serialPort.writeData(sendCommand.data(using: .ascii)!) // someData is an NSData object
                self.read()
            }
            catch{print("failed to send command")}
        }
    }
    
    
    // Reads commands from the pump
    func serialPort(_ serialPort: SerialPort, didReceive data: Data) {
        let string = String(data: data, encoding: .ascii)
        if string == "\u{02}"{
            // Start of transmission
            tempStr = ""
        } else if string == "\u{03}" {
            // End of transmission
           print("Recieved: \(tempStr) from pump")
        } else {
            tempStr += string!
        }
    }
    
    func read(){
        // waiting a short time before reading commands
        do{
        let stringReceived = try serialPort.readString(ofLength: 20)
            print(stringReceived)
        } catch {print("Failed to read data from serial port")}
    }
    
    func close(){
        self.serialPort.closePort()
    }
    
}
