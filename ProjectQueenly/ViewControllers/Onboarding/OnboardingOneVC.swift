//
//  OnboardingOneVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class OnboardingOneVC: UIViewController, UITextFieldDelegate {
    
    var girl = Girl()

    @IBOutlet var emailTextfield: SkyFloatingLabelTextField!
    @IBOutlet var usernameTextfield: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextfield: SkyFloatingLabelTextField!
    @IBOutlet var confirmPasswordTextfield: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegates()
        // Do any additional setup after loading the view.
    }
    
    func setDelegates()
    {
        self.emailTextfield.delegate = self
        self.usernameTextfield.delegate = self
        self.passwordTextfield.delegate = self
        self.confirmPasswordTextfield.delegate = self
    }
    
    func userfieldCheck()
    {
        if self.emailTextfield.text != "" && self.usernameTextfield.text != "" && (self.passwordTextfield.text != "")
        {
            self.createUserWithText()
        }
        else
        {
            let alert = UIAlertController(title: "Missing Info!", message: "Please make sure you fillout all of the info!", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancel = UIAlertAction(title: "Got It", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func createUserWithText()
    {
            if self.passwordTextfield.text == self.confirmPasswordTextfield.text
            {
                
                AuthService.instance.registerUser(withEmail: (self.emailTextfield?.text)!, Password: (self.passwordTextfield?.text!)!, DisplayName: (self.usernameTextfield?.text)!, userCreationComplete: { (completed, error) in
                    
                    if completed && self.confirmPasswordTextfield?.text! == self.passwordTextfield?.text!
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
        
    }
    
    @IBAction func awesomeBtnPressed(_ sender: Any)
    {
//        self.userfieldCheck()
        self.performSegue(withIdentifier: "toOnboardingVCTwoSegue", sender: nil)
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toOnboardingVCTwoSegue"
        {
            
            var nextVC = segue.destination as? OnboardingTwoVC
            nextVC?.email = self.emailTextfield.text!
            nextVC?.password = self.passwordTextfield.text!
            nextVC?.username = self.usernameTextfield.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }

}
