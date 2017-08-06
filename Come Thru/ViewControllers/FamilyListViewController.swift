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

class FamilyListViewController: UIViewController, UITableViewDelegate {
    
    
    @IBAction func signOutButton(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            do {
                try? Auth.auth().signOut()
                
                if Auth.auth().currentUser == nil {
                    let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
                    
                    self.present(loginVC, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    @IBOutlet weak var imageScreen: UIImageView!
    
    var emptyArray = [String]()
    
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




