//
//  OnboardingFourVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField


class OnboardingFourVC: UIViewController {

    @IBOutlet var designerTxtField: SkyFloatingLabelTextField!
    @IBOutlet var sizeTxtFld: SkyFloatingLabelTextField!
    @IBOutlet var favoriteColorTxtField: SkyFloatingLabelTextField!
    @IBOutlet var shilouetteTxtField: SkyFloatingLabelTextField!
    @IBOutlet var waistTxtField: SkyFloatingLabelTextField!
    @IBOutlet var bustTxtField: SkyFloatingLabelTextField!
    @IBOutlet var hipTxtField: SkyFloatingLabelTextField!
    @IBOutlet var heightTxtField: SkyFloatingLabelTextField!
    
    var designer = String()
    var size = Int()
    var shilouette = String()
    var color = String()
    var waist = Int()
    var bust = Int()
    var hip = Int()
    var height = Int()
    var image = UIImage()
    var imageString = String()
    var username = String()
    var userOnborded = Bool()
    
    
    var girl = Girl()
    
    var userRef = Firestore.firestore().collection("Users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bindToKeyboard()

        print(girl)
        print(self.username)

        // Do any additional setup after loading the view.
    }

    
    func addParamsToUser()
    {

        self.userOnborded = true
        
        self.size = ((self.sizeTxtFld.text! as NSString).integerValue)
        self.bust = ((self.bustTxtField.text! as NSString).integerValue)
        self.waist = ((self.waistTxtField.text! as NSString).integerValue)
        self.hip = ((self.hipTxtField.text! as NSString).integerValue)
        self.height = ((self.heightTxtField.text! as NSString).integerValue)
        
        var userData = ["size": self.size, "bust": self.bust, "waist": self.waist, "hip":self.hip, "height":self.height]
        
            
        userRef.document((Auth.auth().currentUser?.uid)!).updateData(userData)
        print("Model Set")
        print(self.girl)
        
        
    }
    
    func transformImageToDataString(image:UIImage) -> Data
    {
        let metaData = UIImagePNGRepresentation(image)
        
        return metaData!
    }

    
    @IBAction func completeProfileCreationBtn(_ sender: Any)
    {
        self.addParamsToUser()
        performSegue(withIdentifier: "toOnboardingVCFiveSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toOnboardingVCFiveSegue"
        {
            var nextVC = segue.destination as? OnboardingFiveVC
        }
    }

}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
