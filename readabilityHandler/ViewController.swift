//
//  ViewController.swift
//  readabilityHandler
//
//  Created by Marco Barnig on 11/11/2016.
//  Copyright © 2016 Marco Barnig. All rights reserved.
//

import Cocoa

let notifyKeyPipe = "pipe"

var stdoutText = ""
var stderrText = "" 

class ViewController: NSViewController {
    
    let outputPipe = OutputPipe()
    
    @IBOutlet var stdoutTextView: NSTextView!
    @IBOutlet var stderrTextView: NSTextView! 
    
    func outputText() {
        stdoutTextView.string = stdoutText
        stderrTextView.string = stderrText
    }

    @IBAction func testPipe(_ sender: Any) {
        outputPipe.myTask()
    }  // end func
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.outputText), name: NSNotification.Name(rawValue: notifyKeyPipe), object: nil)     }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}  // end class

