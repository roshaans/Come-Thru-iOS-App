//
//  DetailedViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 8/6/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
   
    @IBOutlet weak var whatScrollLabel: UITextView!
    
    @IBOutlet weak var whereScrollLabel: UITextView!
    @IBOutlet weak var whenScrollLabel: UITextView!
    @IBOutlet weak var addScrollLabel: UITextView!
    var user: Event?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let user = user {
            // 2
            whatScrollLabel.text = user.whatis
            whenScrollLabel.text = user.whenis
            whereScrollLabel.text = user.whereis
            addScrollLabel.text = user.AdditionalInfo

            if user.AdditionalInfo == "" || user.AdditionalInfo == nil {
                addScrollLabel.text = "NONE"
            } 
            else {
            
//            addDetailedLabel.text = user.AdditionalInfo
            }
        }
//        else {
//            // 3
////            whatDetailedLabel.text = ""
////            whereDetailedLabel.text = ""
////            whenDetailedLabel.text = ""
////            addDetailedLabel.text = ""
//        }
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
