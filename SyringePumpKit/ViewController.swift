//
//  ViewController.swift
//  SyringePumpKit
//
//  Created by Steven DiGregorio on 5/21/20.
//  Copyright © 2020 Steven DiGregorio. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
        
    var controller: SyringePumpContoller? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

// MARK: - Variables
    @IBOutlet weak var connectionIndicator: NSImageView!
    @IBOutlet weak var diameterField: NSTextField!
    @IBOutlet weak var rateField: NSTextField!
    @IBOutlet weak var stopTimeField: NSTextField!
    @IBOutlet weak var stopVolField: NSTextField!
    @IBOutlet weak var timeElapsedField: NSTextField!
    @IBOutlet weak var volElapsedField: NSTextField!

// MARK: - Actions
    @IBAction func connect(_ sender: NSButton) {
        controller = SyringePumpContoller(port: "/dev/tty.usbserial")
        updateConnectIndicator()
    }
        
    
    @IBAction func updateValues(_ sender: NSButton) {
        controller?.setDiameter(of: diameterField.stringValue)
        controller?.setRate(rate: rateField.stringValue, units: .microLiterPerHour) // <- change rate to be dynamic
        controller?.setDirection(of: .infuse) //<- change to be dynamic
        
        // update view controller
        updateConnectIndicator()
        
    }
    
    @IBAction func playPause(_ sender: NSButton) {
        controller?.run()
    }
    
    @IBAction func stop(_ sender: NSButton) {
        controller?.pause()
    }


// MARK: - Update functions
    
    func updateConnectIndicator(){
        if (controller?.communicator.serialPort.isOpen)!{
            connectionIndicator.image = NSImage(named: "NSStatusAvailable")
        } else {
            connectionIndicator.image = NSImage(named: "NSStatusUnavailable")
        }
    }

}
