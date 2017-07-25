//
//  FIndFamilyViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/11/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

class FIndFamilyViewController: UIViewController {
    //MARK: - Properties
    
    var users = [User]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 70
        
    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        // Do any additional setup after loading the view.
    }
    func loadList(notification: NSNotification){
       
                self.tableView.reloadData()
           
    }

    
    
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.destination is FamilyListViewController {
//           
//                   }
//        }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserFollowService.usersExcludingCurrentUser { [unowned self] (users) in
            self.users = users
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }}}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

extension FIndFamilyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
    }
    
    //FIXME: Fix blah blah
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFamilyCell") as! FindFamilyCell
        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: FindFamilyCell, atIndexPath indexPath: IndexPath) {
        let user = users[indexPath.row]
        
     cell.familyLabel.text = user.username
     cell.followButton.isSelected = user.isFamily
        
    }
}


extension FIndFamilyViewController: FIndFamilyCellDelegate {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFamilyCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        followButton.isUserInteractionEnabled = false
        let followee = users[indexPath.row]
        
        UserFollowService.setIsFollowing(!followee.isFamily, fromCurrentUserTo: followee) { (success) in
            print("In the closure")
            defer {
                followButton.isUserInteractionEnabled = true
            }
            
            guard success else { return }
            
            followee.isFamily = !followee.isFamily
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
