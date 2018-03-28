//
//  OrderSummaryVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit

class OrderSummaryVC: UIViewController {

    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    // Static Labels
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var orderedLabel: UILabel!
    @IBOutlet var sellerLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var priceTotalLabel: UILabel!
    
    // Reactive Labels
    @IBOutlet var buyerLabel: UILabel!
    @IBOutlet var orderedDateLabel: UILabel!
//    @IBOutlet var sellerLabel: UILabel!
    @IBOutlet var shippedLabel: UILabel!
//    @IBOutlet var priceTotalLabel: UILabel!
    
    
    // Progress View
    @IBOutlet var progressView: UIProgressView!
    
    // Buttons
    @IBOutlet var detailsBtn: UIButton!
    @IBOutlet var measurementsBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
