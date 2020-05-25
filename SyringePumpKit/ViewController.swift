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

    @IBOutlet weak var inputTextField: NSTextField!
    
    @IBOutlet weak var recievedTextField: NSTextField!
    
    @IBAction func connect(_ sender: NSButton) {
        self.controller.info()
    }
    
    @IBAction func sendButtonPressed(_ sender: NSButton) {
        let command = inputTextField.stringValue
        controller.go(command: command)
    }
    


}

