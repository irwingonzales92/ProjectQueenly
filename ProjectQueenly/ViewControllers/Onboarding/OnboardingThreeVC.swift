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

class OnboardingThreeVC: UIViewController {

    @IBOutlet var imageView: RoundImageView!
    @IBOutlet var usernameTxtField: SkyFloatingLabelTextField!
    
    var girl = Girl()
    
    var imagePickerController = UIImagePickerController()
    
    var userProfileImage = UIImage()
    var userDisplayName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bindToKeyboard()
        self.usernameTxtField.text = self.userDisplayName
        
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
    
    func setUserParams()
    {
        self.userProfileImage = self.imageView.image!
        self.userDisplayName = self.usernameTxtField.text!

        let metaData = UIImagePNGRepresentation(self.userProfileImage)

        let userData = ["userId": Auth.auth().currentUser?.uid ?? String(), "displayName": self.userDisplayName, "userImage": metaData] as [String : Any]
        
        userRef.document((Auth.auth().currentUser?.uid)!).updateData(userData)
//
//        UserDefaults.standard.set(self.userDisplayName, forKey: "name")
        
        
//        let ref = userRef.document((Auth.auth().currentUser?.uid)!)
////        ref.getModel(Girl.self) { (girl, err) in
////            if err == nil
////            {
////
////            }
//        ref.setModel(girl as! FirestoreModel)
        
        

        
//        return userData
    }
    
    func setDelegates()
    {
        self.imagePickerController.delegate = self
        self.usernameTxtField.delegate = self
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
            var nextVC = segue.destination as? OnboardingFourVC
            self.setUserParams()
            nextVC?.image = self.imageView.image!
            nextVC?.username = self.userDisplayName
            debugPrint(nextVC?.girl)
        }
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
