//
//  LoginVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore
import VideoSplashKit

class LoginVC: VideoSplashViewController, Alertable, FBSDKLoginButtonDelegate
{

    var girl: Girl? = nil
    
    @IBOutlet var blurView: RoundedBlurView!
    //    @IBOutlet var webView: WKWebView!
    @IBOutlet var logoImgView: UIImageView!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var signupBtn: UIButton!
    @IBOutlet var toLbl: UILabel!
    @IBOutlet var loginBtn: RoundedShadowButton!
    var emailTextField: UITextField?
    var passwordTextField: UITextField?
    var usernameTextField: UITextField?
    var confirmPasswordTextfield: UITextField?
    var realUsernameTextField: UITextField?
//    var fbBtn: FBSDKLoginButton?

    @IBOutlet var fbBtn: FBSDKLoginButton!
    var window: UIWindow?
    
    // Access Token
    let accessToken = FBSDKAccessToken.current()
    let fbParamaters = ["fields": "id, email, first_name, last_name, password, picture.type(large)"]
    
    
    override var prefersStatusBarHidden:Bool { return true }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        

        
        
        self.fbBtn = FBSDKLoginButton(frame: CGRect(x: 192, y: 524, width: 166, height: 48))
        self.fbBtn?.delegate = self
        view.addSubview(fbBtn!)
        
        
        self.fbBtn?.readPermissions = ["email", "public_profile"]
        
        self.logoImgView.frame = CGRect(x: -78, y: 0, width: 530, height: 421)
        view.addSubview(self.logoImgView)
        
        self.signupBtn.frame = CGRect(x: 144, y: 607, width: 87, height: 32)
        view.addSubview(self.signupBtn)
        
        self.loginBtn.frame = CGRect(x: 18, y: 524, width: 166, height: 48)
        view.addSubview(self.loginBtn)
        
        
//        self.checkUserState()
        
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
            
            
            
            AuthService.instance.loginUser(withEmail: (self.emailTextField?.text)!, andPassword: (self.passwordTextField?.text!)!) { (completed, error) in
                if completed
                {
                    print("It works!")
                    self.showAlert("Login Successful")
                    
                    print("User Successfully Logged in")
                    NotificationCenter.default.post(name: USER_IS_LOGGED_IN, object: nil)
                    
                    self.girl?.email = self.emailTextField?.text
                    self.girl?.onboarded = false
//                    userRef.document((Auth.auth().currentUser?.uid)!).setModel(self.girl!)
//                    self.initalizeUserObject()
//                    print(self.girl?.email)
//
//                    self.checkUserState()
                    
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
        performSegue(withIdentifier: "toOnboardingSegue", sender: nil)
    }
    
}

