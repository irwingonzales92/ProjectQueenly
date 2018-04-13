//
//  OnboardingFiveVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase


class OnboardingFiveVC: UIViewController, AddPostVCDelegate {
    
    let postType = State.ISO
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func didSetPostType() -> State {
        return postType
    }
    
    @IBAction func letsMakeAPostBtnPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let postVC = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as? AddPostVC
        present(postVC!, animated: true, completion: nil)
    }
    
    @IBAction func navigateToHomeVCOnBtnPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "RootVC") as? RootVC
        present(rootVC!, animated: true, completion: nil)
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
