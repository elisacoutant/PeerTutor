//
//  CourSelectionViewController.swift
//  PeerTutor
//
//  Created by Elisa Coutant on 11/13/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CourSelectionViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    var datesViewController: SelectDatesViewController?
    let courseList = ["CS105", "CS119", "CS120" ,"CS121", "CS186", "CS187", "CS190", "CS220", "CS230", "CS240", "CS250", "CS305", "CS311", "CS320", "CS325", "CS326", "CS328", "CS335", "CS345", "CS377", "CS383", "CS410", "CS453", "CS460", "CS491", "CS503", "CS514", "CS520", "CS546", "CS575", "CS589"]

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "courseCell" ,  for: indexPath)
        cell.textLabel?.text = courseList[indexPath.row]
        return cell
    }
    

    
    var selectedItems: [String] = []
    public func tableView(_ tableView: UITableView, didSelectRowAt IndexPath: IndexPath)
    {
        let currentCell = tableView.cellForRow(at: IndexPath)

        if( tableView.cellForRow(at: IndexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark){
            
            tableView.cellForRow(at: IndexPath)?.accessoryType = UITableViewCellAccessoryType.none
            
            selectedItems = selectedItems.filter{ $0 != (currentCell?.textLabel?.text)! }
            
        }
        else{
            tableView.cellForRow(at: IndexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            self.selectedItems.append((currentCell?.textLabel?.text)!)
        }
    }
    
    @IBAction func selectCourseButton(_ sender: Any) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is SelectDatesViewController
        {
            let vc = segue.destination as? SelectDatesViewController
            vc?.selectedCourses = selectedItems
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
