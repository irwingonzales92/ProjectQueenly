//
//  GownDescriptionTableViewCell.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/25/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class GownDescriptionTableViewCell: UITableViewCell {

    @IBOutlet var descriptionLabel: UILabel!
    
    var item: GownDataViewModelItem?
    {
        didSet
        {
            guard let item = item as? GownDataDescriptionItem else {return}
            descriptionLabel.text = item.description
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
