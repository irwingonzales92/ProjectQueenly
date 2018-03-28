//
//  GownPriceTableViewCell.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/25/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class GownPriceTableViewCell: UITableViewCell {

    @IBOutlet var priceRangeLabelOne: UILabel!
    
    var item: GownDataViewModelItem?
    {
        didSet
        {
            guard let item = item as? GownDataPriceItem else {return}
            priceRangeLabelOne.text = String(item.priceOne)
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
