//
//  OnboardingFourVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class OnboardingFourVC: UIViewController {

    @IBOutlet var designerTxtField: RoundedCornerTextField!
    @IBOutlet var sizeTxtFld: RoundedCornerTextField!
    @IBOutlet var favoriteColorTxtField: RoundedCornerTextField!
    @IBOutlet var shilouetteTxtField: RoundedCornerTextField!
    @IBOutlet var waistTxtField: RoundedCornerTextField!
    @IBOutlet var bustTxtField: RoundedCornerTextField!
    @IBOutlet var hipTxtField: RoundedCornerTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func completeProfileCreationBtn(_ sender: Any)
    {
        performSegue(withIdentifier: "toOnboardingVCFiveSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        if segue.identifier == "toOnboardingVCFiveSegue"
//        {
//            var nextVC = segue.destination as? OnboardingTwoVC
////            nextVC?.recievedGown = self.gown
//        }
    }

}
