//
//  OnboardingThreeVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class OnboardingThreeVC: UIViewController {

    @IBOutlet var imageView: RoundImageView!
    @IBOutlet var usernameTxtField: RoundedCornerTextField!
    
        var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buildProfileBtnPressed(_ sender: Any)
    {
//        UserDefaults.standard.set(self.usernameTxtField.text, forKey: "name")
        self.performSegue(withIdentifier: "toOnboardingVCFourSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toOnboardingVCFourSegue"
        {
            var nextVC = segue.destination as? OnboardingTwoVC
            //            nextVC?.recievedGown = self.gown
        }
    }

}
