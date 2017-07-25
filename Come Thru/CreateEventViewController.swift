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
    var usernamesRef: DatabaseReference!
    var progressList = [UITextField]()
    var newArrayOfStrings = [String]()
var usernamesInFamilyList = [String]()
    
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
            
            
         //   self.addKeyToArray()
            self.checkWhoIsInFamilyList()
            self.progressBar.setProgress(1.0, animated: true)
            
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.sentLabel.text = "Event created and sent to family!"

            }     }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
   
    
  override func viewWillAppear(_ animated: Bool) {
//    checkWhoIsInFamilyList()
// print("I just printed all of your family members :)")
//    checkWhoIsInFamilyList()

    }
    
    func checkWhoIsInFamilyList() {
        
        usernamesRef = Database.database().reference()
        usernamesRef.child("following").child(User.current.username).observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.usernamesInFamilyList = []
            
            if let dict = snapshot.value as? [String: Bool] {
                
                for (key, _) in dict {
                    self.usernamesInFamilyList.append("\([key] as [String])")
                   
                }
              
                self.addKeyToArray()//                self.myFamilyListTableView.reloadData()
            }
            
            
            //            self.myFamilyListTableView.reloadData()
            
        }
        )
    }
    
    
    func addKeyToArray(){
        //self.checkWhoIsInFamilyList()
        let key = ref.childByAutoId().key
        let usersinFamilyList = self.usernamesInFamilyList
        let events = ["ID": key,
                      "What": whatField.text! as String,
                      "Where": whereField.text! as String,
                      "When": whenField.text! as String,
                      "AdditionalInfo": additionalField.text! as String]
//            ,
//                      "Who?": self.usernamesInFamilyList as [String]] as [String : Any]
        let event2 = ["Who:": self.usernamesInFamilyList as [String]]
        print("Print out family list \(usersinFamilyList)")
        var keyString = [key]

        
    usernameRef.child("Event Creation Keys").observeSingleEvent(of: .value, with: { (snapshot) in
        
        if let arrayOfStrings = snapshot.value as? [String] {
            //parertArray.append(contentsOf: arrayOfStrings)
            keyString.append(contentsOf: arrayOfStrings)
            
            self.newArrayOfStrings.append(contentsOf: keyString)
        }
        
        self.ref.child(key).setValue(events)
        self.usernameRef.child("Event Creation Keys").setValue(keyString)
       
         print(keyString)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       ref = Database.database().reference().child("Events").child("\(User.current.uid)")
        
        
        usernameRef = Database.database().reference().child("usersTest").child("\(User.current.uid)")
      
        
        
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
