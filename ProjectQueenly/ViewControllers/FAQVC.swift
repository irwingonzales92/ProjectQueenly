//
//  FAQVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/5/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class FAQVC: UIViewController {

    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var dismissVC: UIButton!
    
    @IBAction func dismissVCOnBtnPressed(_ sender: Any)
    {
        self.dismiss(animated: true) {
            print("FAQ VC dismissed")
        }
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
