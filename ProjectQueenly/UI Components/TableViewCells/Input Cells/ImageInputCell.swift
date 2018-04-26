//
//  ImageInputCell.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/24/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

protocol ImageInputCellDelegate
{
    func willDisplayImagePickerOnBtnPressed(action: Selector)
}

class ImageInputCell: UITableViewCell {


    @IBOutlet var gownImageView: UIImageView!
    var delegate: ImageInputCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func willDisplayImagePickerOnBtnPressed(action: Selector)
    {
    self.gownImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        self.gownImageView.isUserInteractionEnabled = true
//        self.gownImageView.image = UIImage(named: "dressicon")
        
    }

}
