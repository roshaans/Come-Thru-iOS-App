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

    var usernameRef:DatabaseReference!
var usernameRefs:DatabaseReference!
    var segment = 0
    var usernamesInFamilyList = [String]()
    var ref:DatabaseReference!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var eventCreated = [Event]()
    var eventInvited = [Event2]()
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
       
        
        eventViewTable.dataSource = self
        
        eventViewTable.tableFooterView = UIView()
        eventViewTable.rowHeight = 160
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        retrieveUID()
        retrieveEventUID()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var arrayOfStrings = [String]()
    var event = [String]()
    
   
    
    

    
    func retrieveUID() {
        
        
        usernameRef = Database.database().reference().child("usersTest").child("\(User.current.uid)")
        
        usernameRef.child("Event Creation Keys").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let arraysOfStrings = snapshot.value as? [String] {
                self.arrayOfStrings = []
                self.arrayOfStrings.append(contentsOf: arraysOfStrings)
                print(self.arrayOfStrings)
                
                self.loopOverUid()
                
            }
            
            
        })
    }
    
    func retrieveEventUID() {
        
        
        
        usernameRefs = Database.database().reference().child("usersTest").child("\(User.current.uid)")
        
        usernameRefs.child("InvitedToEvents").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot.value)
            print("Printed snapshot Value")
            if let local = snapshot.value as? [String] {
                self.event = []
                self.event.append(contentsOf: local)
                print(self.event)
                print("I printed event uid")
                self.loopOverEventUid()
                
            }
            
        })
        

        
    }
    func loopOverUid(){
        self.eventCreated = [Event]()
        print(arrayOfStrings)
        print( "THIS IS THE ARRAY OF STRING")
        for item in arrayOfStrings {
            //NOTTTTTTEEEE!!!!!!! FIRST ADD SOMETHING TO THE ARRAY OF STRINGS IDIOT
            ref = Database.database().reference().child("Events").child("\(User.current.uid)")
            ref.child("\(item)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String: Any] {
                    print("ABOUT TO PRINT EVENT!!!")
                    let whereis = dict["Where"]!
                    let whenis = dict["When"]!
                    let whatis = dict["What"]!
                    let AdditionalInfo = dict["AdditionalInfo"]!
                    
                    let events = Event(whatis: whatis as! String, whereis: whereis as! String, whenis: whenis as! String, AdditionalInfo: AdditionalInfo as! String)
                    self.eventCreated.append(events)
                    print("ABOUT TO PRINT EVENT!!!")
                    print(self.eventCreated)
                    self.eventViewTable.reloadData()
                    ////                for (key, _) in dict {
                    ////                    self.emptyArray.append("\(key)")
                    ////                    print(self.emptyArray)
                    
                }
                
                self.eventViewTable.reloadData()
                
                //              //  self.myFamilyListTableView.reloadData()
                //
                //            }
                //self.myFamilyListTableView.reloadData()
            }
            )
        }
        
    }
    func loopOverEventUid(){
       
        self.eventInvited = [Event2]()
        print(eventInvited)
        print("I printed even Invited")
        print( "THIS IS THE ARRAY OF STRING")
        for item in event {
            //NOTTTTTTEEEE!!!!!!! FIRST ADD SOMETHING TO THE ARRAY OF STRINGS IDIOT
            print("I am inside items")
            ref = Database.database().reference().child("usersTest").child("\(User.current.uid)").child("invitedto")
            
            ref.child("\(item)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String: Any] {
                    print("ABOUT TO PRINT EVENT!!!")
                    let whereis2 = dict["Where"]!
                    let whenis2 = dict["When"]!
                    let whatis2 = dict["What"]!
                    let AdditionalInfo2 = dict["AdditionalInfo"]!
                    let usernameCreator2 = dict["Owner"]!
                    
                    let events = Event2(whatis2: whatis2 as! String, whereis2: whereis2 as! String, whenis2: whenis2 as! String, AdditionalInfo2: AdditionalInfo2 as? String, usernameCreator2: usernameCreator2 as! String)
                    
                    self.eventInvited.append(events)
                    print("ABOUT TO PRINT EVENT!!!")
                    print(self.eventInvited)
                    self.eventViewTable.reloadData()
                    ////                for (key, _) in dict {
                    ////                
                   // self.emptyArray.append("\(key)")
                    ////                    print(self.emptyArray)
                    
                }
                
                self.eventViewTable.reloadData()
                
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
     
        switch segment {
            
        case 0:  return self.eventCreated.count
            
            
        case 1: return self.eventInvited.count
       
        default: return 1
        
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch segment  {
        case 0:
            
             let cell = eventViewTable.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCellTableViewCell
             print("Case 0")
            cell.whatLabel?.text = eventCreated[indexPath.row].whatis
            cell.whereLabel?.text = eventCreated[indexPath.row].whereis
            cell.whenLabel?.text = eventCreated[indexPath.row].whenis
            cell.addLabel?.text = eventCreated[indexPath.row].AdditionalInfo
            return cell

            
        case 1:
            let cell = eventViewTable.dequeueReusableCell(withIdentifier: "EventCreatedCell", for: indexPath) as! EventCreatedCell
            print("Case 1")
            cell.whatInvitedLabel?.text = eventInvited[indexPath.row].whatis2
            cell.whereInvitedLabel?.text = eventInvited[indexPath.row].whereis2
            cell.whenIvitedLabel?.text = eventInvited[indexPath.row].whenis2
            cell.addInvitedLabel?.text = eventInvited[indexPath.row].AdditionalInfo2
            cell.usernameLabel?.text = eventInvited[indexPath.row].usernameCreator2
            return cell
        default:
            break
       
        }
    let cell = eventViewTable.dequeueReusableCell(withIdentifier: "nothing", for: indexPath) as! EventCellTableViewCell
       return cell
        
        
    }
}
