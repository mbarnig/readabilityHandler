//
//  OutputPipe.swift
//  readabilityHandler
//
//  Created by Marco Barnig on 13/11/2016.
//  Copyright © 2016 Marco Barnig. All rights reserved.
//

import Cocoa

class OutputPipe: NSObject {
    
    func myTask() {      
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "echo 1; sleep 1; echo 2; sleep 1; echo 3 for stderr >&2; sleep 1; echo 4" ]
        outputMessages(Task: task) 
        task.launch()
    }  // end func    
    
    func outputMessages(Task: Process) {
        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        Task.standardOutput = stdoutPipe
        Task.standardError = stderrPipe
        
        let stdoutHandle = stdoutPipe.fileHandleForReading
        stdoutHandle.readabilityHandler = { stdoutPipe in
            if let line = String(data: stdoutPipe.availableData, encoding: String.Encoding.utf8) {
                DispatchQueue.main.async() {
                    stdoutText += line
                    NotificationCenter.default.post(name: Notification.Name(rawValue: notifyKeyPipe), object: self) 
                }  // end dispatch
            } else {
                DispatchQueue.main.async() {
                    stdoutText += "There was an error"
                    NotificationCenter.default.post(name: Notification.Name(rawValue: notifyKeyPipe), object: self) 
                }  // end dispatch
            }  // end if
        }  // end stdoutPipe
        
        let stderrHandle = stderrPipe.fileHandleForReading
        stderrHandle.readabilityHandler = { stderrPipe in
            if let line = String(data: stderrPipe.availableData, encoding: String.Encoding.utf8) {
                DispatchQueue.main.async() {
                    stderrText += line
                    NotificationCenter.default.post(name: Notification.Name(rawValue: notifyKeyPipe), object: self) 
                }  // end dispatch
            } else {
                DispatchQueue.main.async() {
                    stderrText += "There was an error"
                    NotificationCenter.default.post(name: Notification.Name(rawValue: notifyKeyPipe), object: self) 
                }  // end dispatch
            }  // end if
        }  // end stderrPipe   
    }  // end func

}  // end class
