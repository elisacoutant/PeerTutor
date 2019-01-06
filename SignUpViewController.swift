//
//  SignUpViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 10/17/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//
import Firebase
import FirebaseAuth
import UIKit
import FirebaseDatabase


class SignUpViewController: UIViewController {
    
    var ref: DatabaseReference?
    var addTutorSession : SelectDatesViewController?
    
    //First name text field
    @IBOutlet weak var firstName: UITextField!
    
    //Last name text field
    @IBOutlet weak var lastName: UITextField!
    
    //Email text field
    @IBOutlet weak var email: UITextField!
   
    //Password text field
    @IBOutlet weak var password: UITextField!
    
    //Create account button
    @IBAction func createAccount(_ sender: Any) {
        
        ref = Database.database().reference()

        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error ) in
            
            if(user != nil){
                print ("success")

                print(self.firstName.text! + " " + self.lastName.text!)
                //Get users UID and save it as their name undneath this
                let userID = Auth.auth().currentUser!.uid

                
                let name = self.firstName.text!
                let lastname = self.lastName.text!
                let times = [""]
                let courses = [""]
                let app = [""]
                let price = ""
                
                let avail:[String : Any] = [
                    "name": name,
                    "lastname": lastname,
                    "times" : times,
                    "courses" : courses,
                    "appointments": app,
                    "price" : price
                ]
                //To create Locations
                self.ref?.child("sessions").child(userID).setValue(avail)
                
            }
            else{
                if let myError = error?.localizedDescription{
                    print(myError)
                }
                else{
                    print("Error!")
                }
            }
        })
    }
    
    //Cancel button
    @IBAction func cancel(_ sender: Any) {
        performSegue(withIdentifier: "cancelSignUp", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
