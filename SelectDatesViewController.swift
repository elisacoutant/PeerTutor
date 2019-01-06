//
//  SelectDatesViewController.swift
//  PeerTutor
//
//  Created by Elisa Coutant on 11/14/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class SelectDatesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dateList = ["Monday 8-9am", "Monday 9-10am", "Monday 10-11am", "Monday 11-12am", "Monday 12-1pm", "Monday 1-2pm","Monday 2-3pm","Monday 3-4pm","Monday 4-5pm", "Monday 5-6pm", "Monday 6-7pm", "Monday 7-8pm",
        "Tuesday 8-9am", "Tuesday 9-10am", "Tuesday 10-11am", "Tuesday 11-12am", "Tuesday 12-1pm", "Tuesday 1-2pm","Tuesday 2-3pm","Tuesday 3-4pm","Tuesday 4-5pm", "Tuesday 5-6pm", "Tuesday 6-7pm", "Tuesday 7-8pm","Wednesday 8-9am", "Wednesday 9-10am", "Wednesday 10-11am", "Wednesday 11-12am", "Wednesday 12-1pm", "Wednesday 1-2pm","Wednesday 2-3pm","Wednesday 3-4pm","Wednesday 4-5pm", "Wednesday 5-6pm", "Wednesday 6-7pm", "Wednesday 7-8pm", "Thursday 8-9am", "Thursday 9-10am", "Thursday 10-11am", "Thursday 11-12am", "Thursday 12-1pm", "Thursday 1-2pm","Thursday 2-3pm","Thursday 3-4pm","Thursday 4-5pm", "Thursday 5-6pm", "Thursday 6-7pm", "Thursday 7-8pm", "Friday 8-9am", "Friday 9-10am", "Friday 10-11am", "Friday 11-12am", "Friday 12-1pm", "Friday 1-2pm","Friday 2-3pm","Friday 3-4pm","Friday 4-5pm", "Friday 5-6pm", "Friday 6-7pm", "Friday 7-8pm"]
    var selectedItems: [String] = []
    var selectedCourses = [String]()
    var name = ""

    var ref: DatabaseReference?



    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "dateCell" ,  for: indexPath)
        cell.textLabel?.text = dateList[indexPath.row]
        return cell
    }
    
    
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
    
    @IBAction func selectButton(_ sender: Any) {
        //For each course add all the times.
        let userID = Auth.auth().currentUser!.uid
        
        ref = Database.database().reference().child("sessions").child(userID)
        
    
        ref?.updateChildValues(
            ["times": selectedItems,
             "courses": selectedCourses
            ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
