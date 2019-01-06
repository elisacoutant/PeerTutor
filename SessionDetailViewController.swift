//
//  SessionDetailViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 10/28/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MessageUI

class SessionDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tutorName: UILabel!
    @IBOutlet weak var tutorTime: UILabel!
    
    @IBOutlet weak var priceText: UILabel!
    
    var getName = String()
    var getTime = String()
    var price = ""
    
    var ref: DatabaseReference?
    var ref1: DatabaseReference?


    var newSession = [String]()
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tutorName.text = getName
        tutorTime.text = getTime
        priceText.text = "Price: $" + price + "/hour"

    }

    @IBAction func bookSession(_ sender: Any) {

            
        let userID = Auth.auth().currentUser!.uid
        
        //Set the new session
        newSession.append(getName + " " + getTime + " " + price)
        
        ref = Database.database().reference().child("sessions").child(userID)
        
        
        ref?.updateChildValues(
            ["appointments": newSession,
            ])

    }
    
    @IBAction func sendEmail(_ sender: Any) {
        
        let mailComposeViewController = configureMailController()
        if(MFMailComposeViewController.canSendMail()){
            self.present(mailComposeViewController, animated:true, completion:nil)
        }
        else{
            showMailError()
        }
    }
    
    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["ecoutant@umass.edu"])
        mailComposerVC.setSubject("Tutor Session")
        mailComposerVC.setMessageBody("I'd like to join this tutor session", isHTML: false)
        return mailComposerVC
    }
    
    func showMailError(){
        let sendMailErrorAlert = UIAlertController(title: "Could not send Email", message: "Your device cannot send an email", preferredStyle: .alert
        )
        let dismiss = UIAlertAction(title: "Ok", style: .default)
        
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
