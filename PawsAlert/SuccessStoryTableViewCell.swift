//
//  SuccessStoryTableViewCell.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/17/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class SuccessStoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var volunteerImage: UIImageView!
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var successStory: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
