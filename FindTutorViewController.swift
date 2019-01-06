//
//  FindTutorViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 10/17/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit

class FindTutorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var resultsController: TutorSearchResultsTableViewController?
    var selectRow = 0
    var date = ""
    var selectedDOW = ""
    
    //Dataata
    let courses = ["CS105", "CS119", "CS120" ,"CS121", "CS186", "CS187", "CS190", "CS220", "CS230", "CS240", "CS250", "CS305", "CS311", "CS320", "CS325", "CS326", "CS328", "CS335", "CS345", "CS377", "CS383", "CS410", "CS453", "CS460", "CS491", "CS503", "CS514", "CS520", "CS546", "CS575", "CS589"]
    let courseComponent = 0
    
    //Course picker
    @IBOutlet weak var coursePicker: UIPickerView!
    
    
    //Date picker    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        //Grab day of week
        let formatter = DateFormatter();
        formatter.dateFormat = "EEEE"
        selectedDOW = formatter.string(from: datePicker.date)
        
        
        //Grab date
        date = dateFormatter.string(from: datePicker.date)
    }
    
    //Search button
    @IBAction func searchButton(_ sender: Any) {
        performSegue(withIdentifier: "searchResultsSegue", sender: self)
    }
    
    
    //Functions for course picker
    //How many columns.
    func numberOfComponents(in coursePicker: UIPickerView) -> Int {
        return 1
    }
    
    //How many rows.
    func pickerView(_ coursePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == courseComponent){
            return courses.count
        }
        return -1;
    }
    
    
    func pickerView(_ coursePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == courseComponent){
            selectRow = row
            return courses[row]
        }
        return "Error";
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TutorSearchResultsTableViewController
        {
            let vc = segue.destination as? TutorSearchResultsTableViewController
            vc?.selectedCourse = courses[selectRow]
            vc?.selectedDate   =  date
            vc?.selectedDOW = selectedDOW
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        coursePicker.delegate = self
        coursePicker.dataSource = self
        navigationController?.navigationBar.isHidden = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
