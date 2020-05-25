//
//  ViewController.swift
//  SyringePumpKit
//
//  Created by Steven DiGregorio on 5/21/20.
//  Copyright © 2020 Steven DiGregorio. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
        
    let controller = syringePump(port: "/dev/tty.usbserial")
//    let controller = SerialPortDemoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    


}

