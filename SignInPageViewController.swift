//
//  SignInPageViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 10/17/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInPageViewController: UIViewController {
    

    
    //Username text field
    @IBOutlet weak var usernameText: UITextField!
    
    //Password text field
    @IBOutlet weak var passwordText: UITextField!
    
    //Login button
    @IBAction func submitButton(_ sender: Any) {
       
        if( usernameText.text != "" && passwordText.text != ""){
            
            Auth.auth().signIn(withEmail: usernameText.text!, password: passwordText.text!, completion: { (user, error ) in
                if (user != nil){
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
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
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
