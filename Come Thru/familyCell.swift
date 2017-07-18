//
//  familyCell.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/12/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
protocol familyCellDelegate: class {
    
}
class familyCell: UITableViewCell {
//link label text here
    
    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
