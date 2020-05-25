//
//  test.swift
//  SyringePumpKit
//
//  Created by Steven DiGregorio on 5/25/20.
//  Copyright © 2020 Steven DiGregorio. All rights reserved.
//

import Foundation
import ORSSerial

class test{
    func go(){
        let someData = "run\r\n".data(using: .ascii)!
        let serialPort = ORSSerialPort(path: "/dev/tty.usbserial")
        serialPort?.baudRate = 9600
        serialPort?.open()
        serialPort?.send(someData) // someData is an NSData object
        serialPort?.close() // Later, when you're done with the port
    }
}
