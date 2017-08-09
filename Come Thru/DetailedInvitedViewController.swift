//
//  DetailedInvitedViewController.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 8/7/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

class DetailedInvitedViewController: UIViewController {
    
    
    
    @IBOutlet weak var whatInvitedView: UITextView!
    
    @IBOutlet weak var whereInvitedView: UITextView!
    
    @IBOutlet weak var whenInvitedView: UITextView!
   
    @IBOutlet weak var addInvitedView: UITextView!
    
    @IBOutlet weak var usernameInvitedView: UILabel!
    var invited: Event2?
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
        if let invited = invited {
            whatInvitedView.text = invited.whatis2
            whereInvitedView.text = invited.whereis2
            whenInvitedView.text = invited.whenis2
            usernameInvitedView.text = "\(invited.usernameCreator2!)"
            if invited.AdditionalInfo2 == "" || invited.AdditionalInfo2 == nil {
                addInvitedView.text = "NONE"
            } else {
                    addInvitedView.text = invited.AdditionalInfo2
            }
        } else {
            whatInvitedView.text = ""
            whereInvitedView.text = ""
            whenInvitedView.text = ""
            addInvitedView.text = ""
            usernameInvitedView.text = ""
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

}
