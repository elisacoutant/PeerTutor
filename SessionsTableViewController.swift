//
//  SessionsTableViewController.swift
//  TutorApp
//
//  Created by Elisa Coutant on 10/24/18.
//  Copyright © 2018 Elisa Coutant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

//Table view cell
struct SessionCell {
    // ...
}

class SessionCellTableViewCell: UITableViewCell {
 
}

class SessionsTableViewController: UITableViewController {

    @IBOutlet weak var sessionsTable: UITableView!
   
    
    var ref: DatabaseReference?
    var handle: DatabaseHandle?

    var currentSessions = [String]()
    var status = ["You have no upcoming sessions."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the current sessions of user and reference
        let userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference()

        
        
        ref!.child("sessions").child(userID).observe(.value, with: { (snapshot) in
            let data = snapshot.childSnapshot(forPath: "appointments").value as? [String]
            //for each session in the database, add it to currentSession
            
                for d in data!{
                    if(d != ""){
                        self.currentSessions.append(d)
                    }
                }
            
            //Reload the data
            self.tableView.reloadData()
            
        })
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                currentSessions.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                
                let userID = Auth.auth().currentUser!.uid
                
                
                ref = Database.database().reference().child("sessions").child(userID)
                
                
                ref?.updateChildValues(
                    ["appointments": currentSessions,
                     ])
                
                tableView.reloadData()
                
            }
        }
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if(!currentSessions.isEmpty){
            return currentSessions.count
        }
        else{
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentSessions.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = storyboard.instantiateViewController(withIdentifier: "UpcomingSessionDetailsViewController") as! UpcomingSessionDetailsViewController
        
        var selectedString = currentSessions[indexPath.row]
        let fullDetailArr = selectedString.components(separatedBy: " ")
        
        var nam = fullDetailArr[0] + " " + fullDetailArr[1]
        var tim = fullDetailArr[2] + " " + fullDetailArr[3]
        
        var price = fullDetailArr[4]
        
        DvC.tutorNam = nam
        DvC.tutorTim = tim
        DvC.tutorPrice = price
        
    self.navigationController?.pushViewController(DvC, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! SessionCellTableViewCell
        
        if(!currentSessions.isEmpty){
            var selectedString = currentSessions[indexPath.row]
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
