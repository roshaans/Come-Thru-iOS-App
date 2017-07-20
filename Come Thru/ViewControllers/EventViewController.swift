//
//  EventViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/10/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

import FirebaseDatabase
class EventViewController: UIViewController {
    var segment = 0
    var ref:DatabaseReference!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var event = [Event]()

    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segment = 0
        case 1:
            segment = 1
        default:
            break
        }
            }
    @IBOutlet weak var eventViewTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if segmentedControl.selectedSegmentIndex == 0 {
//            testLabel.text = "0"
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
//                testLabel.text = "1"
        }
        
        eventViewTable.dataSource = self
        
        eventViewTable.tableFooterView = UIView()
        eventViewTable.rowHeight = 160
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if segmentedControl.selectedSegmentIndex == 0 {
//            testLabel.text = "0"
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
//            testLabel.text = "1"
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkEventUID() {
    }
    func reloadEventData() {
        self.event = []
        
        ref = Database.database().reference().child("CreatedEvents").child("\(User.current.username)")
        
//        child("\(key)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("Running this!")
            
           print(snapshot.value)
//            if let dict = snapshot.value as? [String: String] {
//                
//                let whereis = dict["Where"] as! String
//                let whenis = dict["When"] as! String
//                let whatis = dict["What"] as! String
//                let AdditionalInfo = dict["AdditionalInfo"] as! String
//                
//                let events = Event(whatis: whatis, whereis: whereis, whenis: whenis, AdditionalInfo: AdditionalInfo)
//                self.event.append(events)
//                print("ABOUT TO PRINT EVENT!!!")
//                print(self.event)
////                for (key, _) in dict {
////                    self.emptyArray.append("\(key)")
////                    print(self.emptyArray)
//                
////                }
//              //  self.myFamilyListTableView.reloadData()
//               
//            }
            //self.myFamilyListTableView.reloadData()
            
            
            
            
            
            
        }
        )
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//}

extension EventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventViewTable.dequeueReusableCell(withIdentifier: "EventCell") as! EventCellTableViewCell
        
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: EventCellTableViewCell, atIndexPath indexPath: IndexPath) {
        
    
    }
}
