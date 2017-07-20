//
//  FamilyListViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/10/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class FamilyListViewController: UIViewController, UITableViewDelegate {
    
    var emptyArray = [String]()
    var users = [User2]()
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle?
   
    
    @IBOutlet weak var myFamilyListTableView: UITableView!
    @IBAction func reloadButton(_ sender: UIBarButtonItem) {
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFamilyListTableView.delegate = self
        myFamilyListTableView.tableFooterView = UIView()
        myFamilyListTableView.rowHeight = 71
//        let user = User(uid: "hello", username: "userrr")
      
        //reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        reloadData()
       
    }
    //
    
    
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
//                let username = dict["\(User.current.username)"] as! String
//                let user = User2(username: username)
//               
//                
//                self.users.append(user)
//               print("Snapshot printing")
//                print(self.users)
                           }
            self.myFamilyListTableView.reloadData()
            
    
            
        
     
    
        }
        )
    }
}



extension FamilyListViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//    }
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




