//
//  OnboardingOneVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class OnboardingOneVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func awesomeBtnPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toOnboardingVCTwoSegue", sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toOnboardingVCTwoSegue"
        {
            var nextVC = segue.destination as? OnboardingTwoVC
            //            nextVC?.recievedGown = self.gown
        }
    }

}
