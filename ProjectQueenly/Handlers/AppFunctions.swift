//
//  AppFunctions.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/28/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import Foundation
import UIKit

class AppFunctions: NSObject {
    
    class func setMainViewController(vc: UIViewController) {
        
        
        UIView.transition(with: ((UIApplication.shared.delegate?.window)!)!, duration: 0.3, options: .showHideTransitionViews, animations: {
            
            let state = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            ((UIApplication.shared.delegate?.window)!)!.rootViewController = vc
            UIView.setAnimationsEnabled(state)
            
        }, completion: nil)
    }
}
