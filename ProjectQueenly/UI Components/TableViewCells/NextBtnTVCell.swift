//
//  NextBtnTVCell.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/12/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

protocol NextBtnTVCellDelegate: class
{
    // Adding ISO
    func didSetGownParams()
    
    // Viewed Offer, Accepting
    func isAcceptingOffer()
    
    // Viewed Post, Making Offer
    func isMakingOffer()
    
    // Viewing Post
    func isViewingPost()
    
    
}

class NextBtnTVCell: UITableViewCell {
    
    weak var delegate: NextBtnTVCellDelegate?

    @IBOutlet var callToActionBtn: UIButton!
    @IBAction func didPostOnBtnPressed(_ sender: Any)
    {
        delegate?.didSetGownParams()
    }

}
