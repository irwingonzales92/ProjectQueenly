//
//  LoginVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, Alertable
{

    @IBOutlet var loginWithFbButton: UIButton!
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var confirmPasswordTextfield = UITextField()
    var usernameTextField = UITextField()
    
//    let alert = FCAlertView()
    
    override func viewDidLoad()
    {
//        self.alert.delegate = self as! FCAlertViewDelegate
        super.viewDidLoad()
        
        view.bindToKeyboard()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "UserLoggedIn"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginWithFbBtnPressed(_ sender: Any)
    {
        
    }
    @IBAction func loginWithEmailBtnPressed(_ sender: Any)
    {
        let alert = UIAlertController(title: "Login", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textfield) in
                    self.emailTextField = textfield
                    textfield.placeholder = "Email"
                }
        
        alert.addTextField { (textfield) in
                    self.passwordTextField = textfield
                    textfield.placeholder = "Password"
                }
        
        let save = UIAlertAction(title: "Submit", style: .default) { (alert) in
            AuthService.instance.loginUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!) { (completed, error) in
                if completed
                {
                    print("It works!")
                    self.showAlert("Login Successful")
                    
                    print("User Successfully Logged in")
                    NotificationCenter.default.post(name: USER_IS_LOGGED_IN, object: nil)
                    
//                    NotificationCenter.default.addObserver(self, selector: #selector(self.dismissView), name: USER_IS_LOGGED_IN, object: nil)
                }
                else
                {
                    print("Something went wrong")
                    debugPrint(error)
                    
                    if error != nil
                    {
                        if let errorCode = AuthErrorCode(rawValue: error!._code)
                        {
                            
                            switch errorCode
                            {
                            case .emailAlreadyInUse:
                                self.showAlert("Email is in use")
                                
                            case .invalidEmail:
                                self.showAlert(ERROR_MSG_INVALID_EMAIL)
                                
                            default:
                                self.showAlert(ERROR_MSG_UNEXPECTED_ERROR)
                                print(error as Any)
                                debugPrint(error)
                            }
                        }
                    }
                }
            }
        }

        alert.addAction(save)

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signupBtnPressed(_ sender: Any)
    {
        
        let alert = UIAlertController(title: "Signup", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textfield) in
            self.emailTextField = textfield
            textfield.placeholder = "Email"
        }
        
        alert.addTextField { (textfield) in
            self.passwordTextField = textfield
            textfield.placeholder = "Password"
        }
        
        alert.addTextField { (textfield) in
            self.confirmPasswordTextfield = textfield
            textfield.placeholder = "Confirm Password"
        }
        
        let save = UIAlertAction(title: "Submit", style: .default) { (alert) in
            AuthService.instance.registerUser(withEmail: self.emailTextField.text!, Password: self.passwordTextField.text!, userCreationComplete: { (completed, error) in
                
                if completed && self.confirmPasswordTextfield.text! == self.passwordTextField.text!
                {
                    print("It works!")
                    self.showAlert("Signup Successful")
                    
                    print("User Successfully Signed up")
//                    NotificationCenter.default.addObserver(self, selector: #selector(self.dismissView), name: USER_IS_LOGGED_IN, object: nil)
                    self.perform(#selector(self.dismissView))
                    self.viewWillAppear(true)
                }
                else
                {
                    print("Something went wrong")
                    debugPrint(error)
                    
                    if error != nil
                    {
                        if let errorCode = AuthErrorCode(rawValue: error!._code)
                        {
                            
                            switch errorCode
                            {
                            case .emailAlreadyInUse:
                                self.showAlert("Email is in use")
                                
                            case .invalidEmail:
                                self.showAlert(ERROR_MSG_INVALID_EMAIL)
                                
                            default:
                                self.showAlert(ERROR_MSG_UNEXPECTED_ERROR)
                                print(error as Any)
                                debugPrint(error)
                            }
                        }
                    }
                }
            })
        }
        
        alert.addAction(save)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func dismissView()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
