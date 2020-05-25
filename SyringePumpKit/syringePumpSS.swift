//
//  syringePumpSS.swift
//  SyringePumpKit
//
//  Created by Steven DiGregorio on 5/25/20.
//  Copyright © 2020 Steven DiGregorio. All rights reserved.
//

import Foundation
import SwiftSerial

class syringePumpSS {
    
    let serialPort: SerialPort
    
    init(port: String) {
        self.serialPort = SerialPort(path: port)
        self.serialPort.setSettings(receiveRate: .baud9600,
                                    transmitRate: .baud9600,
        minimumBytesToRead: 0,
        timeout: 0, /* 0 means wait indefinitely */
        parityType: .none,
        sendTwoStopBits: false, /* 1 stop bit is the default */
        dataBitsSize: .bits8,
        useHardwareFlowControl: false,
        useSoftwareFlowControl: false,
        processOutput: false)
        do {
            try self.serialPort.openPort(toReceive: false, andTransmit: true)
        } catch {
            print("Couldnt open")
            print("error: \(error)")
        }
    }
        
//    func info(){
//        print("is open: \(self.serialPort.)")
//        print("Parity: \(serialPort.parity)")
//        print("Name: \(serialPort.name)")
//        print("Path: \(serialPort.path)")
//        print("Description: \(serialPort.description)")
//    }
    
    func go(command: String){
        let sendCommand = "\(command)\n\r"
        do {
//            let written = try self.serialPort.writeString(sendCommand)
            let written = try self.serialPort.writeData(sendCommand.data(using: .ascii)!)
            print("bytes written: \(written)")
        } catch {
            print("Couldnt write")
            print("error: \(error)")
        }
    }
        
    
}
