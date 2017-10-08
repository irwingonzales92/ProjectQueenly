//
//  PostTableViewCell.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/5/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var contactButton: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
