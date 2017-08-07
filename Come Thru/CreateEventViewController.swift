//
//  CreateEventViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/11/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
import FirebaseDatabase
class CreateEventViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func resetButton(_ sender: Any) {
        whatField.text = ""
        whereField.text = ""
        whenField.text = ""
        additionalField.text = ""
        self.sentLabel.text = ""
        self.progressBar.setProgress(0, animated: false)
        
    }
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
        
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
            //THIS IS THE CODE THAT GOES GETS RUN!
            
         
            self.addKeyToArray()
            self.progressBar.setProgress(1.0, animated: true)
            
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.sentLabel.text = "Event created and sent to family!"
                self.tabBarController?.selectedIndex = 2

            }
        
        
            
            
        })
        
        
        
        )

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
        
        let userID: String = User.current.username
      
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
                    self.dictofinviteuid.append(keys)

                    self.reference.child("usersTest").child(usa.uid).child("invitedto").child(keys).setValue(events)
                    self.reference.child("usersTest").child(usa.uid).child("InvitedToEvents").setValue(self.dictofinviteuid)
                 
                    
                    
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
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        
        datePicker.addTarget(self, action: #selector(CreateEventViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        whenField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        
        toolbar.tintColor = UIColor.white
        
        let todayButton = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateEventViewController.todayPressed(sender:)))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CreateEventViewController.donePressed(sender:)))
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.yellow
        
        label.textAlignment = NSTextAlignment.center
        
        label.text = "Select a Date"
        
        let labelButton = UIBarButtonItem(customView: label)
        
        toolbar.setItems([todayButton, flexButton, labelButton, flexButton, doneButton], animated: true)
        
        whenField.inputAccessoryView = toolbar
//        whatField: UITextField!
//        @IBOutlet weak var whenField: UITextField!
//        
//        @IBOutlet weak var whereField: UITextField!
//        @IBOutlet weak var additionalField:
        self.whatField.delegate = self
        self.whenField.delegate = self
        self.additionalField.delegate = self as? UITextViewDelegate
        self.whereField.delegate = self
        
       ref = Database.database().reference().child("Events").child("\(User.current.uid)")
        
        reference = Database.database().reference()
        usernameRef = Database.database().reference().child("usersTest").child("\(User.current.uid)")
        invitations = Database.database().reference().child("Invitations")
      
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func donePressed(sender: UIBarButtonItem) {
        
        whenField.resignFirstResponder()
    }
    
    func todayPressed(sender: UIBarButtonItem) {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.medium
        
        formatter.timeStyle = DateFormatter.Style.medium
        
       whenField.text = formatter.string(from: NSDate() as Date)
        
        whenField.resignFirstResponder()
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.medium
        
        formatter.timeStyle = DateFormatter.Style.short
        
        whenField.text = formatter.string(from: sender.date)
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
