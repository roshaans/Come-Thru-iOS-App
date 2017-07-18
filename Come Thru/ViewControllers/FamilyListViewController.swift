//
//  FamilyListViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/10/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FamilyListViewController: UIViewController, UITableViewDelegate {
    
    
    
    var isInMyFamilyList = [String]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    @IBOutlet weak var myFamilyListTableView: UITableView!
    @IBAction func reloadButton(_ sender: UIBarButtonItem) {
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("following").child(User.current.username).observe(.childAdded, with: { (snapshot) in
            
            let username = snapshot.key as? String
            
            if let userr = username {
                
                self.isInMyFamilyList = Array(Set(self.isInMyFamilyList))
                
                self.isInMyFamilyList.append(userr)
                self.isInMyFamilyList = Array(Set(self.isInMyFamilyList))
                
                
                self.myFamilyListTableView.reloadData()
                
                
                
            }
        })
        
        
        isInMyFamilyList = Array(Set(isInMyFamilyList))
        print("Myfamily list contains \(isInMyFamilyList)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFamilyListTableView.delegate = self
        myFamilyListTableView.tableFooterView = UIView()
        myFamilyListTableView.rowHeight = 71
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("following").child(User.current.username).observe(.childAdded, with: { (snapshot) in
            
            let username = snapshot.key as? String
            
            if let userr = username {
                
                self.isInMyFamilyList = Array(Set(self.isInMyFamilyList))
                
                self.isInMyFamilyList.append(userr)
                self.isInMyFamilyList = Array(Set(self.isInMyFamilyList))
                self.myFamilyListTableView.reloadData()
                
                
                
            }
        })
        
        
        isInMyFamilyList = Array(Set(isInMyFamilyList))
        print("Myfamily list contains \(isInMyFamilyList)")}
    //
    
    
    
    
    
    
}

extension FamilyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isInMyFamilyList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myFamilyListTableView.dequeueReusableCell(withIdentifier: "familyCell") as! familyCell
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func configure(cell: familyCell, atIndexPath indexPath: IndexPath) {
        
        let username = isInMyFamilyList[indexPath.row]
        
        
        cell.labelText.text = username
        
        
    }
}




