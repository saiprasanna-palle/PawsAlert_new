//
//  UserPetsCellTableViewCell.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/18/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import ParseUI

class UserPetsCellTableViewCell: PFTableViewCell {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petImage: PFImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
