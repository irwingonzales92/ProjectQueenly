//
//  NextBtnTVCell.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/12/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

enum UserButtonAction
{
    case setGown, acceptingOffer, makingOffer, viewingOffer
}

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
    var action: UserButtonAction = .setGown

    @IBOutlet var callToActionBtn: UIButton!
    @IBAction func didPostOnBtnPressed(_ sender: Any)
    {
        
        switch self.action
        {
        case .setGown:
            delegate?.didSetGownParams()
        case .acceptingOffer:
            delegate?.isAcceptingOffer()
        case .makingOffer:
            delegate?.isMakingOffer()
        case .viewingOffer:
            delegate?.isViewingPost()
        }
//        delegate?.didSetGownParams()
    }

}
