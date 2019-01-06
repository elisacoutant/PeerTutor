//
//  SelectPriceViewController.swift
//  PeerTutor
//
//  Created by Elisa Coutant on 12/5/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SelectPriceViewController: UIViewController {

    var ref: DatabaseReference?
    
    @IBOutlet weak var priceText: UITextField!
    
    @IBAction func selectButton(_ sender: Any) {
        let userID = Auth.auth().currentUser!.uid
        
        var price = priceText.text
        
        ref = Database.database().reference().child("sessions").child(userID)
        
        
        ref?.updateChildValues(
            ["price": price,
            ])
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
