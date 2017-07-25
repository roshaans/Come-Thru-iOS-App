//
//  EventCellTableViewCell.swift
//  Come Thruxccgjk
//
//  Created by Roshaan Siddiqui on 7/20/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

class EventCreatedCell: UITableViewCell {
    
    @IBOutlet weak var addInvitedLabel: UILabel!
    @IBOutlet weak var whenIvitedLabel: UILabel!
    @IBOutlet weak var whereInvitedLabel: UILabel!
    @IBOutlet weak var whatInvitedLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
