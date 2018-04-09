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


class OnboardingFourVC: UIViewController, UITextFieldDelegate {

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
    var imageString = Data()
    var username = String()
    var userOnborded = Bool()
    
    
    var girl = Girl()
    
    var userRef = Firestore.firestore().collection("Users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bindToKeyboard()

        print(girl)
        print(self.username)
        
        self.designerTxtField.delegate = self
        self.favoriteColorTxtField.delegate = self
        self.bustTxtField.delegate = self
        self.heightTxtField.delegate = self
        self.hipTxtField.delegate = self
        self.waistTxtField.delegate = self
        self.shilouetteTxtField.delegate = self 
        

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
        self.color = self.favoriteColorTxtField.text!
        self.designer = self.designerTxtField.text!
        self.imageString = self.transformImageToDataString(image: self.image)
        
        let userData = ["size": self.size, "bust": self.bust, "waist": self.waist, "hip":self.hip, "height":self.height, "favorite color": self.color, "favorite desginer": self.designer] as [String : Any]
        
            
        userRef.document((Auth.auth().currentUser?.uid)!).setData(userData, options: SetOptions.merge())
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }

}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
