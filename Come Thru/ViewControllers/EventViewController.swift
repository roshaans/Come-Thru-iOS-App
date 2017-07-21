//
//  EventViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/10/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

import FirebaseDatabase

class EventViewController: UIViewController {
    var usernameRef: DatabaseReference!

    var segment = 0
    
    var ref:DatabaseReference!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var event = [Event]()

    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segment = 0
        case 1:
            segment = 1
        default:
            
            break
        }
        eventViewTable.reloadData()
            }
    @IBOutlet weak var eventViewTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   loopOverUid()
        retrieveUID()
        
        eventViewTable.dataSource = self
        
        eventViewTable.tableFooterView = UIView()
        eventViewTable.rowHeight = 160
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if segmentedControl.selectedSegmentIndex == 0 {
                print("Created Events clicked")
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            print("Created Invited clicked")
        }
       // loopOverUid()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var arrayOfStrings = [String]()
    func retrieveUID() {
        
        
        usernameRef = Database.database().reference().child("usersTest").child("\(User.current.uid)")
            usernameRef.child("Event Creation Keys").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let arraysOfStrings = snapshot.value as? [String] {
                    
                    self.arrayOfStrings.append(contentsOf: arraysOfStrings)
                    print(self.arrayOfStrings)
                    
                    self.loopOverUid()
                
                }
                
            
            
            })
        }
    

    func loopOverUid(){
        self.event = [Event]()
        print(arrayOfStrings)
        print( "THIS IS THE ARRAY OF STRING")
        for item in arrayOfStrings {
            //NOTTTTTTEEEE!!!!!!! FIRST ADD SOMETHING TO THE ARRAY OF STRINGS IDIOT
            ref = Database.database().reference().child("CreatedEvents").child("\(User.current.username)")
            ref.child("\(item)").observeSingleEvent(of: .value, with: { (snapshot) in
            
                if let dict = snapshot.value as? [String: String] {
                    print("ABOUT TO PRINT EVENT!!!")
                    let whereis = dict["Where"]!
                    let whenis = dict["When"]!
                    let whatis = dict["What"]!
                    let AdditionalInfo = dict["AdditionalInfo"]!
                    
                    let events = Event(whatis: whatis, whereis: whereis, whenis: whenis, AdditionalInfo: AdditionalInfo)
                    self.event.append(events)
                    print("ABOUT TO PRINT EVENT!!!")
                    print(self.event)
                    self.eventViewTable.reloadData()
                    ////                for (key, _) in dict {
                    ////                    self.emptyArray.append("\(key)")
                    ////                    print(self.emptyArray)
                    
                }
                //              //  self.myFamilyListTableView.reloadData()
                //
                //            }
                //self.myFamilyListTableView.reloadData()
                
                
                
                
                
                
            }
            )
        }
    
        }
        
        
    
    }
    
    

//        child("\(key)")
        
       
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//}

extension EventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print("The count of the rows is ")
        return self.event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch segment  {
        case 0:
             let cell = eventViewTable.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCellTableViewCell
            cell.whatLabel?.text = event[indexPath.row].whatis
            cell.whereLabel?.text = event[indexPath.row].whereis
            cell.whenLabel?.text = event[indexPath.row].whenis
            cell.addLabel?.text = event[indexPath.row].AdditionalInfo
            return cell
        
        case 1:
            let cell = eventViewTable.dequeueReusableCell(withIdentifier: "invitedEventCell", for: indexPath) as! EventCellTableViewCell
            return cell
        default:
            break
       
        }
    let cell = eventViewTable.dequeueReusableCell(withIdentifier: "nothing", for: indexPath) as! EventCellTableViewCell
       return cell
        
        
    }
}
