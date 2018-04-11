//
//  ViewController.swift
//  Mail
//
//  Created by Antonio Prado on 4/11/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var container: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        container?.image = #imageLiteral(resourceName: "mail")
        container?.layer.cornerRadius = 50
        container?.center = view.center
        container?.layer.masksToBounds = true
        container?.isUserInteractionEnabled = true
        view.addSubview(container!)
        
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(pressDetected))
        longPressed.minimumPressDuration = 2
        container?.addGestureRecognizer(longPressed)
        
    }
    
    @objc func pressDetected (){
        print("Press detected!!!!")
        
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.setToRecipients(["antoniopradoo@gmail.com"])
            composer.setCcRecipients(["anjeprol_prado@hotmail.com"])
            composer.setSubject("iOS Mail App")
            composer.mailComposeDelegate = self
            composer.setMessageBody("<h1><b><center> \(NSLocalizedString("HELLO", comment: "")), Antonio!</center></b></h1>", isHTML: true)
            let data = UIImageJPEGRepresentation(#imageLiteral(resourceName: "mail"), 0)
            
            composer.addAttachmentData(data!, mimeType: "image/jpg", fileName: "iconMail")
            present(composer, animated: true, completion: nil)
        } else {
            print("No tienes cuenta configurada")
        }

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        var status = ""
        switch result {
        case .saved:
            status = "Saved!"
        case .cancelled:
            status = "Cancelled!"
        case .failed:
            status = "Failed!"
        case .sent:
            status = "Sent!"
        }
        print(status)
        controller.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

