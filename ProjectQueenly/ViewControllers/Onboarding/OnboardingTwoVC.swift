//
//  OnboardingTwoVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class OnboardingTwoVC: UIViewController {
    
    var email = String()
    var username = String()
    var password = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStartedBtnPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toOnboardingVCThreeSegue", sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toOnboardingVCThreeSegue"
        {
            var nextVC = segue.destination as? OnboardingThreeVC
            nextVC?.userUsername = self.username
            nextVC?.userEmail = self.email
            nextVC?.userPassword = self.password
        }
    }

}
