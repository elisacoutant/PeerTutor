//
//  SettingsViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 10/28/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {

    
    @IBAction func editInfo(_ sender: Any) {
    }
    @IBAction func becomeATutor(_ sender: Any) {
    
    }
    
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
