////
////  DetailedViewController.swift
////  Come Thru
////
////  Created by Roshaan Siddiqui on 8/6/17.
////  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
////
//
//import UIKit
//
//class DetailedViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // 1
//        if let identifier = segue.identifier {
//            // 2
//            if identifier == "displayDetailedInfo" {
//                // 3
//                let indexPath = eventViewTable.indexPathForSelectedRow!
//                // 2
//                let user = eventCreated[indexPath.row]
//                // 3
//                let displayNoteViewController = segue.destination as! EventViewController
//                // 4
//                displayNoteViewController.user = user
//                
//            }
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
