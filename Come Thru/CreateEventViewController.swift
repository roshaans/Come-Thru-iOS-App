//
//  CreateEventViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/11/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
import FirebaseDatabase
class CreateEventViewController: UIViewController {
    
    var ref: DatabaseReference!
    var usernameRef: DatabaseReference!
    var invitations: DatabaseReference!
    var usernamesRef: DatabaseReference!
    var reference: DatabaseReference!
    var progressList = [UITextField]()
    var newArrayOfStrings = [String]()
    var uidOfFamily = [User]()
var usernamesInFamilyList = [String]()
    var inviteesList = [String]()
    @IBOutlet weak var whatField: UITextField!
       @IBOutlet weak var whenField: UITextField!

    @IBOutlet weak var whereField: UITextField!
    @IBOutlet weak var additionalField: UITextView!
    
    @IBOutlet weak var progressBar: UIProgressView!
   
    @IBOutlet weak var sentLabel: UILabel!
    
    @IBAction func createButton(_ sender: UIButton) {
       
        if (whatField.text == "" || whereField.text == "" || whenField.text == "")
        {
            self.showError()
        }
        
        showAlert()
        
        //        print(" What: \(what!), Where: \(wheres!), When: \(when!), Who: \(who!) Additional: \(additional ?? "NONE")")
        //    }

    }
 
    
        
    

    
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "All text fields MUST be filled", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlert() {
      
        let what = self.whatField!.text
        let wheres = self.whereField!.text
        let when = self.whenField!.text
        let additional = self.additionalField!.text

        let alert = UIAlertController(title: "Event Detials", message: " What: \(what!) \n Where: \(wheres!) \n When: \(when!) \n Additional: \(additional ?? "NONE")", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Edit or Cancel", style: UIAlertActionStyle.destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
            //THIS IS THE CODE THAT GOES GETS RUN!
            
         
            self.addKeyToArray()
            self.progressBar.setProgress(1.0, animated: true)
            
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.sentLabel.text = "Event created and sent to family!"

            }     }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
   
    
  override func viewWillAppear(_ animated: Bool) {

    }
    
//    func checkWhoIsInFamilyList() {
//        
//        usernamesRef = Database.database().reference()
//        usernamesRef.child("following").child(User.current.username).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            self.usernamesInFamilyList = []
//            
//            if let dict = snapshot.value as? [String: Bool] {
//                
//                for (key, _) in dict {
//                    self.usernamesInFamilyList.append(key) //Retrive all the Usernames into the usernamesInFamilyList array!
//                }
//              
//                self.addKeyToArray()//Run AddKeyToArray
//            
//            
//            } })
//        }
    var dictofinviteuid = [String]()
    var keysOfSpecificUsers = [String]()
    func addKeyToArray(){
        print("Printing FAMILY List \(self.usernamesInFamilyList)")
        self.reference.child("invitation").setValue(self.usernamesInFamilyList)
        self.reference.child("following").child(User.current.username)

        let keys = ref.childByAutoId().key
        
        
       // Data we got from running checWhoIsInFamilyList func!
        
        let userID: [String: String] = [User.current.username: User.current.uid]
      
        let events = ["ID": keys,
                      "What": whatField.text! as String,
                      "Where": whereField.text! as String,
                      "When": whenField.text! as String,
                      "AdditionalInfo": additionalField.text! as String,
                      "Owner": userID] as [String : Any]
     

        var keyString = [keys]//Creating a new list with object "keys"
    
        self.reference.child("usersTest").child(User.current.uid).child("family").observeSingleEvent(of: .value, with: { (snapshot) in
        
            //FIXX THISS
            if let dict = snapshot.value as? [String: String] {
                
                for (key ,value) in dict { //Retrive all the Usernames into the usernamesInFamilyList array!
                    
                    let usa = User.init(uid: value, username: key)
                    
                    
                    print(usa.uid)
                    
                    self.uidOfFamily.append(usa) //Append each object to uidOfFamily
                    
                    //Append event key to keysOfSpecificUsers
                    
                    self.reference.child("usersTest").child(usa.uid).child("invitedto").child(keys).setValue(events)
                    self.reference.child("usersTest").child(usa.uid).child("InvitedToEvents").setValue(keys)
                    //                    let invitationsSent = [
//                        
//                        "usersTest/\(usa.uid)/invitedtoEvents/" : self.keysOfSpecificUsers] as [String: Any]
//                    
//                    self.reference.updateChildValues(invitationsSent) { (error, _) in
//                        if let error = error {
//                            assertionFailure(error.localizedDescription)
//                        }}
                    
                    //self.reference.child("usersTest").child(usa.uid).child("invitedtoEvents").setValue(self.keysOfSpecificUsers)
                    
                    
                }
                
                
                
                
                
            }})
        
    usernameRef.child("Event Creation Keys").observeSingleEvent(of: .value, with: { (snapshot) in
         //let usersinFamilyList = self.usernamesInFamilyList
        
        if let arrayOfStrings = snapshot.value as? [String] {

            keyString.append(contentsOf: arrayOfStrings) //Retrive all EventId's
            
        }
        
    
        self.ref.child(keys).setValue(events) //Set value of Events child to the event creation Details
        self.keysOfSpecificUsers.append(keys)
        
        
        self.usernameRef.child("Event Creation Keys").setValue(keyString) //Add all event UID's inside User model
        })
    }
        
        
       
        
        
    
      
//        self.invitations.child(key).child("Event Owner").child(events["Owner"]!).child("Invitees").setValue(usersinFamilyList)
        
   
      
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       ref = Database.database().reference().child("Events").child("\(User.current.uid)")
        
        reference = Database.database().reference()
        usernameRef = Database.database().reference().child("usersTest").child("\(User.current.uid)")
        invitations = Database.database().reference().child("Invitations")
      
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
