//
//  OnboardingThreeVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class OnboardingThreeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var imageView: RoundImageView!
    @IBOutlet var sizeTextField: SkyFloatingLabelTextField!
    @IBOutlet var heightTextField: SkyFloatingLabelTextField!
    @IBOutlet var bustTextField: SkyFloatingLabelTextField!
    @IBOutlet var waistTextField: SkyFloatingLabelTextField!
    @IBOutlet var hipTextField: SkyFloatingLabelTextField!
    @IBOutlet var shilouetteTextField: SkyFloatingLabelTextField!
    @IBOutlet var favoriteColorTextField: SkyFloatingLabelTextField!
    @IBOutlet var favoriteDesignerTextField: SkyFloatingLabelTextField!
    
    var girl = Girl()
    
    var imagePickerController = UIImagePickerController()
    
    var userProfileImage = UIImage()
    var userDisplayName = String()
    
    var userSize = Int()
    var userHeight = Int()
    var userBust = Int()
    var userHip = Int()
    var userWaist = Int()
    var userShilouette = String()
    var userColor = String()
    var userDeisgner = String()
    var userOnbaorded = true
    
    var userEmail = String()
    var userPassword = String()
    var userUsername = String()
    var data = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bindToKeyboard()
        
        self.setDelegates()
        
        // ImageView & ImagePicker functions
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerSelectedImageView)))
        imageView.isUserInteractionEnabled = true
        self.imagePickerController.delegate = self
    }
    
    func transformImageToDataString(dict: [String:Any?])
    {
        let metaData = UIImagePNGRepresentation(self.imageView.image!)

    }
    
    func checkTextField()
    {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        let textField = SkyFloatingLabelTextField()
        let alertController = UIAlertController()
        
//        switch textField.text? = ""
//        {
//        case self.sizeTextField:
//            alertController.title = "missing size"
//
//        case self.heightTextField:
//            alertController.title = "missing height"
//
//        case self.bustTextField:
//            alertController.title = "missing bust"
//
//        case self.waistTextField:
//            alertController.title = "missing waist"
//
//        case self.hipTextField:
//            alertController.title = "missing hip"
//
//        case self.shilouetteTextField:
//            alertController.title = "missing shilouette"
//
//        case self.favoriteColorTextField:
//            alertController.title = "missing color"
//
//        case self.favoriteDesignerTextField:
//            alertController.title = "missing designer"
//
//
////        case true:
////            alertController.title = "missing info"
////        case false:
////            print("everything is good!")
////            self.setUserParams()
//        case .none:
//            print("everything is good!")
//            self.setUserParams()
//
//        case .some(_):
//            alertController.title = "missing info"
//        }
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)

    }
    
    func setUserParams()
    {
        self.userProfileImage = self.imageView.image!
        self.userHeight = Int(self.heightTextField.text!)!
        self.userSize = Int(self.sizeTextField.text!)!
        self.userBust = Int(self.bustTextField.text!)!
        self.userWaist = Int(self.waistTextField.text!)!
        self.userHip = Int(self.hipTextField.text!)!
        self.userShilouette = self.shilouetteTextField.text!
        self.userColor = self.favoriteColorTextField.text!
        self.userDeisgner = self.favoriteDesignerTextField.text!
        let metaData = UIImagePNGRepresentation(self.userProfileImage)
        



        Auth.auth().createUser(withEmail: self.userEmail, password: self.userPassword) { (user, err) in
            if err == nil
            {
                
                let userData = ["provider": user?.providerID,"email":self.userEmail, "username":self.userUsername, "uid":user?.uid,  "userSize": self.userSize, "userHeight": self.userHeight, "userWaist": self.userWaist, "userBust": self.userBust, "userHip":self.userHip, "userShilouette": self.userShilouette, "userColor": self.userColor, "favoriteDesigner": self.userDeisgner, "favoriteColor": self.userColor, "userImage": metaData, "onboarded":true] as [String : Any]
//                self.userUsername = (user?.displayName)!
                userRef.document().setData(userData)
            }
            else
            {
                print("Onboarding Error: \(err?.localizedDescription)")
                let alert = UIAlertController(title: "There was a problem!", message: "There was an errof: \(err)", preferredStyle: .alert)

                let cancel = UIAlertAction(title: "Got it", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            }
        }

//        userRef.document((Auth.auth().currentUser?.uid)!).setData(userData, options: SetOptions.merge())

    }
    
    func setDelegates()
    {
        self.imagePickerController.delegate = self
        self.heightTextField.delegate = self
        self.sizeTextField.delegate = self
        self.bustTextField.delegate = self
        self.waistTextField.delegate = self
        self.heightTextField.delegate = self
        self.shilouetteTextField.delegate = self
        self.favoriteColorTextField.delegate = self
        self.favoriteDesignerTextField.delegate = self
    }
    
    
    
    @IBAction func buildProfileBtnPressed(_ sender: Any)
    {
//        self.setUserParams()
        self.checkTextField()

        self.performSegue(withIdentifier: "toOnboardingVCFiveSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toOnboardingVCFiveSegue"
        {
            var nextVC = segue.destination as? OnboardingFourVC
//            self.setUserParams()
            debugPrint(nextVC?.girl)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
}
