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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func transformImageToDataString(dict: [String:Any?])
    {
        let metaData = UIImagePNGRepresentation(self.imageView.image!)

    }
    
    func registerUser(withData data: [String: Any])
    {
        AuthService.instance.registerUser(withEmail: self.userEmail, Password: self.userPassword, DisplayName: self.userUsername, userCreationComplete: { (completed, error) in
            
            if completed
            {
                print("It works!")
                
                print("User Successfully Signed up")
                
            }
            else
            {
                print("Something went wrong")
                debugPrint(error?.localizedDescription as! String)
                
                if error != nil
                {
                    if let errorCode = AuthErrorCode(rawValue: error!._code)
                    {
                        
                        switch errorCode
                        {
                        case .emailAlreadyInUse:
                            print("Email is in use")
                            
                        case .invalidEmail:
                            print(ERROR_MSG_INVALID_EMAIL)
                            
                        default:
                            print(ERROR_MSG_UNEXPECTED_ERROR)
                            print(error as Any)
                            debugPrint(error)
                        }
                    }
                }
            }
        })
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
            guard user != nil else {
                
                let userData = ["provider": user?.providerID,"email":self.userEmail, "username":self.userUsername, "uid":user?.uid,  "userSize": self.userSize, "userHeight": self.userHeight, "userWaist": self.userWaist, "userBust": self.userBust, "userHip":self.userHip, "userShilouette": self.userShilouette, "userColor": self.userColor, "favoriteDesigner": self.userDeisgner, "favoriteColor": self.userColor, "userImage": metaData, "onboarded":true] as [String : Any]
                user?.setValuesForKeys(userData)
                return
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
        self.setUserParams()
//        self.registerUser(withData: self.data)
//        UserDefaults.standard.set(self.usernameTxtField.text, forKey: "name")
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
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += keyboardSize.height
//            }
//        }
//    }

}
