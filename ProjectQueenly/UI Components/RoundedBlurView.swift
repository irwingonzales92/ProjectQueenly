//
//  RoundedBlurView.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/26/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class RoundedBlurView: UIVisualEffectView {

    override func awakeFromNib()
    {
        setupView()
    }
    
    func setupView()
    {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowRadius = 5.0
//        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
