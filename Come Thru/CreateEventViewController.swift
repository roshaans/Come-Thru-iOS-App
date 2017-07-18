//
//  CreateEventViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/11/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    var progressList = [UITextField]()
    
    
    @IBOutlet weak var whatField: UITextField!
       @IBOutlet weak var whenField: UITextField!

    @IBOutlet weak var whoField: UITextField!
    @IBOutlet weak var whereField: UITextField!
    @IBOutlet weak var additionalField: UITextView!
    
    @IBOutlet weak var progressBar: UIProgressView!
   
    @IBOutlet weak var sentLabel: UILabel!
    
    @IBAction func createButton(_ sender: UIButton) {
        
        
//        self.progressBar.setProgress(1.0, animated: true)
//      
//        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            self.sentLabel.text = "Event created and sent to family!"
        
//        if let what = whatField.text, let who = whoField.text {
//            
//        }   else {
//                
//                self.showError()
//                return
//            
//            }
        if (whatField.text == "" || whoField.text == "" || whereField.text == "" || whenField.text == "")
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
        let who = self.whoField!.text
        let wheres = self.whereField!.text
        let when = self.whenField!.text
        let additional = self.additionalField!.text

        let alert = UIAlertController(title: "Event Detials", message: " What: \(what!) \n Where: \(wheres!) \n When: \(when!) \n Who: \(who!) \n Additional: \(additional ?? "NONE")", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Edit or Cancel", style: UIAlertActionStyle.destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
            
            
//            SEND OUT THE TEXT
        }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
   
    
  override func viewWillAppear(_ animated: Bool) {
    
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
        
        
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
