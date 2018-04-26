//
//  DescriptionInputCell.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/24/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class DescriptionInputCell: UITableViewCell {

    @IBOutlet var gownDescriptionTextView: RSKPlaceholderTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
