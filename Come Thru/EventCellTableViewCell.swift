//
//  EventCellTableViewCell.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/20/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit

class EventCellTableViewCell: UITableViewCell {

    @IBOutlet weak var whatLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
