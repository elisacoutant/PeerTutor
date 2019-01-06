//
//  BecomeTutorViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 11/12/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit

class BecomeTutorViewController: UIViewController {
    
    let courses = ["CS377", "CS121", "CS453", "CS250"]


    @IBOutlet weak var coursePicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in coursePicker: UIPickerView) -> Int {
        return 1
    }
    
    //How many rows.
    func pickerView(_ coursePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return courses.count
    }
    
    func pickerView(_ coursePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
            return courses[row]
 
    }
    
}
