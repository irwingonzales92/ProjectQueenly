//
//  Alertable.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 11/9/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

//import Foundation
import UIKit
protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(_ msg: String) {
        let alertController = UIAlertController(title: "Error:", message: msg, preferredStyle: .alert)
        let action =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
