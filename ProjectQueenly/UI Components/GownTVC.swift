//
//  GownTVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 1/19/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class GownTVC: UITableViewCell {

    @IBOutlet var gownImageView: UIImageView!
    @IBOutlet var designerLbl: UILabel!
    @IBOutlet var sizeLbl: UILabel!
    @IBOutlet var colorLbl: UILabel!
    
    @IBOutlet var viewBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
