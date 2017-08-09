//
//  FIndFamilyViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/11/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
import SwiftMessages
class FIndFamilyViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    var users = [User]()
    //var filteredUsers = [User]()
    
    
    
    var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func filterContentForSearchText(searchText: String) {
        
        users = users.filter{ user in
            return user.username.lowercased().contains(searchText.lowercased())
            
        }
        
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // searchBar.backgroundColor?.cgColor = UIColor(hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: 0.0)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 70
        
    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
        
        
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
        }}
}



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
//        if searchController.isActive && searchController.searchBar.text != "" {
//            return filteredUsers.count
//            
//        }
        return users.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFamilyCell") as! FindFamilyCell
        cell.delegate = self
        
        
        configure(cell: cell, atIndexPath: indexPath)
        cell.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        
        return cell
    }
    
    func configure(cell: FindFamilyCell, atIndexPath indexPath: IndexPath) {
        let user: User
//        if searchController.isActive && searchController.searchBar.text != "" {
//            user = filteredUsers[indexPath.row]
//            
//        }
//        else{
//
//           cell.followButton.isSelected = user.isFamily
//        }
        
        user = users[indexPath.row]
    cell.followButton.isSelected = user.isFamily
     cell.familyLabel.text = user.username
     
        
    }
}


extension FIndFamilyViewController: FIndFamilyCellDelegate {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFamilyCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        followButton.isUserInteractionEnabled = false
     
        let followee = users[indexPath.row]
        //Button wont press in searched state
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

//extension FIndFamilyViewController: UISearchResultsUpdating {
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        
//        filterContentForSearchText(searchText: searchController.searchBar.text!)
//    }
//    
//}

extension FIndFamilyViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filter through data
        
       
        //self.tableView.reloadData()
        if searchText == "" {
            UserFollowService.usersExcludingCurrentUser { [unowned self] (users) in
                self.users = users
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            
            }}
        if searchText != "" {
            UserFollowService.usersExcludingCurrentUser { [unowned self] (users) in
                self.users = users
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    self.filterContentForSearchText(searchText: searchBar.text!)
                }
            }

            
        }
        
        }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //Make Cancel button SHow
        
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
       
        UserFollowService.usersExcludingCurrentUser { [unowned self] (users) in
            self.users = users
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        
        UserFollowService.usersExcludingCurrentUser { [unowned self] (users) in
            self.users = users
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }}
    
        
 //Show original data
    

    
}


