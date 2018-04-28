//
//  AppCoordinator.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/26/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    var window: UIWindow?
    
    fileprivate var isLoggedIn = false
    fileprivate let navigationController:UINavigationController
    fileprivate var childCoordinators = [Coordinator]()
    
    init(window: UIWindow)
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        var vc = UIViewController()
        
        
    }
}
