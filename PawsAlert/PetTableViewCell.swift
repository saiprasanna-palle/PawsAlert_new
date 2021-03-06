//
//  PetTableViewCell.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 2/22/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import ParseUI

class PetTableViewCell: PFTableViewCell {

    @IBOutlet weak var PetDetail: UILabel!
    @IBOutlet weak var PetName: UILabel!
    @IBOutlet weak var PetImage: PFImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
