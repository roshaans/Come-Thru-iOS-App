//
//  FamilyListViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/10/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuthUI
import FirebaseAuth
import ButtonProgressBar_iOS
import SwiftMessages
import SAConfettiView
class FamilyListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func shareButtonPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["Hello! I found this very cool app to make organizing events a piece of cake! [MY APP LINK]"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
   // @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var familyListButton: UIButton!
    
    @IBAction func signOutButton(_ sender: Any) {
        showAlert()
            }
            // show the alert
    
    
    @IBOutlet weak var imageScreen: UIImageView!
    
    
    var emptyArray = [String]()
    
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle?
   
    
    @IBOutlet weak var myFamilyListTableView: UITableView!
    @IBAction func reloadButton(_ sender: UIBarButtonItem) {
           }
    
    func showAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: "You will be signing out of \(User.current.username).", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sign Out", style: UIAlertActionStyle.default, handler: { action in
            //THIS IS THE CODE THAT GOES GETS RUN!
            
            
            if Auth.auth().currentUser != nil {
                do {
                    try? Auth.auth().signOut()
                    
                    if Auth.auth().currentUser == nil {
                        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
                        
                        self.present(loginVC, animated: true, completion: nil)
                        
                    }
                }
                
            }
        })
        )
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        if UserDefaults.standard.isAppAlreadyLaunchedOnce() {
//            
//            print("This is not the first time!")
//            
//        } else{
//            
//           showFirstTimeMessageScreen()
//        
//        
//        }
        shareButton.layer.cornerRadius = 12
        shareButton.clipsToBounds = true
        familyListButton.layer.cornerRadius = 10
        familyListButton.clipsToBounds = true
        //contactButton.layer.cornerRadius = 10
      //  contactButton.clipsToBounds = true
              myFamilyListTableView.delegate = self
        myFamilyListTableView.tableFooterView = UIView()
        myFamilyListTableView.rowHeight = 71

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
         reloadData()
        
        
       
       
    }
//   func showFirstTimeMessageScreen() {
//    var config = SwiftMessages.Config()
//    // Slide up from the bottom.
//    config.presentationStyle = .center
//    config.dimMode = .gray(interactive: true)
//    let view = MessageView.viewFromNib(layout: .CenteredView)
//    view.button?.isHidden = true
//    // Theme message elements with the warning style.
//    view.configureTheme(.info)
//    // Add a drop shadow.
//    view.configureDropShadow()
//    // Set message title, body, and icon. Here, we're overriding the default warning
//    // image with an emoji character.
//    let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
//    view.configureContent(title: "WELCOME!", body: "Head on to 'ADD BY USERNAME' to add your family!", iconText: iconText)
//    // Show the message.
//    
//    
//    view.buttonTapHandler = { _ in SwiftMessages.hide() }
//    
//    // Hide when message view tapped
//    view.tapHandler = { _ in SwiftMessages.hide() }
//    SwiftMessages.show(config: config, view: view)
//    
//}


    func showMessageScreen() {
        
        var config = SwiftMessages.Config()
        // Slide up from the bottom.
        config.presentationStyle = .center
        config.dimMode = .gray(interactive: true)
        let view = MessageView.viewFromNib(layout: .CenteredView)
        view.button?.isHidden = true
        // Theme message elements with the warning style.
        view.configureTheme(.info)
        // Add a drop shadow.
        view.configureDropShadow()
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        view.configureContent(title: "Hmmmm...", body: "Please go to 'Add By Username' to add people to your family!", iconText: iconText)
        // Show the message.
        
        
        view.buttonTapHandler = { _ in SwiftMessages.hide() }
        
        // Hide when message view tapped
        view.tapHandler = { _ in SwiftMessages.hide() }
        SwiftMessages.show(config: config, view: view)
        
    }
    func reloadData() {
        self.emptyArray = []
        
        ref = Database.database().reference()
        
        ref.child("following").child(User.current.username).observeSingleEvent(of: .value, with: { (snapshot) in
       
            print("We are running it")
            
            if let dict = snapshot.value as? [String: Bool] {
               
                for (key, _) in dict {
                    self.emptyArray.append("\(key)")
                    print(self.emptyArray)
                    
                }

                    self.myFamilyListTableView.reloadData()
            }
            
            if self.emptyArray.isEmpty {
                
                self.showMessageScreen()
            }
            self.myFamilyListTableView.reloadData()
            
    
            
        
     
    
        }
        )
    }
}



extension FamilyListViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(emptyArray.count)
        print("Printing count")
        return emptyArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myFamilyListTableView.dequeueReusableCell(withIdentifier: "familyCell") as! familyCell
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func configure(cell: familyCell, atIndexPath indexPath: IndexPath) {
        
    
       let username = emptyArray[indexPath.row]
        
        
       cell.labelText.text = username
        
        
    }
}
extension UserDefaults {

    func isAppAlreadyLaunchedOnce()->Bool{
    let defaults = UserDefaults.standard
    
    if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
        print("App already launched : \(isAppAlreadyLaunchedOnce)")
        return true
    }else{
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return false
    }
}
}


