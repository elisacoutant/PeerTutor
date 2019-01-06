//
//  TutorSearchResultsTableViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 10/18/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

//Table view cell
struct Headline {
    // ...
}

class HeadlineTableViewCell: UITableViewCell {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
}


class TutorSearchResultsTableViewController: UITableViewController {
    
    //Variables from search
    var selectedCourse = ""
    var selectedDate   = ""
    var selectedDOW = ""
    
    @IBOutlet weak var topLabel: UILabel!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var valueToPass: String!
    var price = ""
    
    var sessions = [String]()
    var status = ["There are no results."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("sessions")
        ref?.observeSingleEvent(of: .value, with: {snapshot in
            for childSnap in snapshot.children{
                let childsnap = childSnap as! DataSnapshot
                //Get the courses, the name and the times.
                let coursesSnap = childsnap.childSnapshot(forPath: "courses").value as? [String]
                let nameSnap = childsnap.childSnapshot(forPath: "name").value as? String
                let lastSnap = childsnap.childSnapshot(forPath: "lastname").value as? String
                let timeSnap = childsnap.childSnapshot(forPath: "times").value as? [String]
                let newPrice = childsnap.childSnapshot(forPath: "price").value as?
                    String
                
                var newName = nameSnap! + " " + lastSnap!
                
                //Go through each course
                for cour in coursesSnap!{
                    //Only continue if they can tutor that course
                    if ( cour == self.selectedCourse ){
                       //Go through each time
                        for time in timeSnap!{
                            //Parse the string and see if the weekday equals selected weekday
                            let day = time.components(separatedBy: " ").first
                            //If the day is correct
                            if(day == self.selectedDOW){
                                //Create a session
                                var newTime = " " + time
                                var newLine = newName + newTime + " " + newPrice!
                                
                                self.sessions.append(newLine)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToSearch", sender: self)
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!sessions.isEmpty){
            return sessions.count
        }
        else {
            return 1;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = storyboard.instantiateViewController(withIdentifier: "SessionDetailViewController") as! SessionDetailViewController
        
        var selectedString = sessions[indexPath.row]
        let fullDetailArr = selectedString.components(separatedBy: " ")
        
        var nam = fullDetailArr[0] + " " + fullDetailArr[1]
        var tim = fullDetailArr[2] + " " + fullDetailArr[3]
        
        var price = fullDetailArr[4]
        
        DvC.getName = nam
        DvC.getTime = tim
        DvC.price = price
        
        
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HeadlineTableViewCell
        
        if(!sessions.isEmpty){
            var selectedString = sessions[indexPath.row]
            let fullDetailArr = selectedString.components(separatedBy: " ")
            
            var nam = fullDetailArr[0] + " " + fullDetailArr[1]
            var tim = fullDetailArr[2] + " " + fullDetailArr[3]
            cell.textLabel?.text = nam + " " + tim
        }
        else{
            cell.textLabel?.text = status[0]
        }

        return cell
    }
}
