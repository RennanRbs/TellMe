//
//  InterfaceController.swift
//  TellMe WatchKit Extension
//
//  Created by Ada 2018 on 22/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var lbMessage: WKInterfaceLabel!
    
    var lastMessage: CFAbsoluteTime = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        
        super.willActivate()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func btnRogerAction() {
        respondToIOS()
    }
    
    func respondToIOS() {
        
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        if lastMessage + 0.2 > currentTime { return }
        
        if WCSession.default.isReachable {
            WCSession.default.sendMessage([String:Any](), replyHandler: nil, errorHandler: nil)
            
        }
        
        lastMessage = CFAbsoluteTimeGetCurrent()
        
    }
    
}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        WKInterfaceDevice().play(.click)
        
        self.lbMessage.setText(message["message"] as? String)
        
    }
    
    
}
