//
//  ViewController.swift
//  TellMe
//
//  Created by Ada 2018 on 22/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    var lastMessage: CFAbsoluteTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textField.delegate = self
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buttonSend(_ sender: Any) {
        
        if let textsend = textField.text{
            sendWatchMessage(textsend)
        }
        
    }
    
    func sendWatchMessage(_ message: String) {
        
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        if lastMessage + 0.2 > currentTime { return }
        
        if WCSession.default.isReachable {
            let messageDict = ["message": message]
            WCSession.default.sendMessage(messageDict, replyHandler: nil, errorHandler: nil)
            
        }
        
        lastMessage = CFAbsoluteTimeGetCurrent()
        
    }
    
}

extension ViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
 
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let alert = UIAlertController.init(title: "TellMe", message: "Copied That", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        //self.textField.endEditing(true)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
        
    }

    
}

extension ViewController: UITextFieldDelegate {
}

