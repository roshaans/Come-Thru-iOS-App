//
//  FindFamilyCell.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/11/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
protocol FIndFamilyCellDelegate: class {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFamilyCell)
    
}

class FindFamilyCell: UITableViewCell {
     weak var delegate: FIndFamilyCellDelegate?

    
    @IBOutlet weak var followButton: UIButton!

    
    @IBOutlet weak var familyLabel: UILabel!

   
    @IBAction func followButtonTapped(_ sender: UIButton) {
    delegate?.didTapFollowButton(sender, on: self)
    }
        
        
        

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
followButton.layer.borderColor = UIColor.clear.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Add to family", for: .normal)
        followButton.setTitle("In Family", for: .selected)
        followButton.setTitleColor(UIColor.white, for: .normal)
        followButton.setTitleColor(UIColor.black, for: .selected)
    }

    

}
