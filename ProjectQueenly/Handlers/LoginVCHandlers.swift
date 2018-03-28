//
//  LoginVCHandlers.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/24/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore


extension LoginVC
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "UserLoggedIn"), object: nil)
        
        let htmlPath = Bundle.main.path(forResource: "WebViewContent", ofType: "html")
        let htmlURL = URL(fileURLWithPath: htmlPath!)
        let html = try? Data(contentsOf: htmlURL)
        
        self.webView.load(html!, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: htmlURL.deletingLastPathComponent())
        self.webView.isUserInteractionEnabled = false;

    }
    
    func checkUserState()
    {
        if self.girl != nil
        {
            if (self.girl?.onboarded == true)
            {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "RootVC") as? RootVC
                present(rootVC!, animated: true, completion: nil)
                debugPrint(self.girl?.onboarded)
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let onbVC = storyboard.instantiateViewController(withIdentifier: "OnboardingOneVC") as? OnboardingOneVC
            present(onbVC!, animated: true, completion: nil)
        }
        
    }
    
    func initalizeUserObject()
    {
        self.girl?.email = Auth.auth().currentUser?.email
        print(self.girl?.documentID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil
        {
            print(error.localizedDescription)
        }
        
        self.storeCredentialPropertiesFromFacebook()
        
    }
    
    func storeCredentialPropertiesFromFacebook()
    {
        guard let accessTokenString = self.accessToken?.tokenString else
        {return}
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials) { (user, err) in
            if err != nil
            {
                print(err?.localizedDescription ?? "")
                
            }
            else
            {
                print(user?.email ?? "")
                
                //                AuthService.instance.
            }
            
            FBSDKGraphRequest(graphPath: "/me", parameters: self.fbParamaters).start(completionHandler: { (connection, result, err) in
                if err != nil
                {
                    debugPrint("Failed to start graph", err?.localizedDescription ?? "")
                    return
                }
                print(result ?? "")
            })
        }
    }
    
    @objc func dismissView()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toOnboardingSegue"
        {
            var nextVC = segue.destination as? OnboardingOneVC
            //            nextVC?.girl = self.girl!
            //            print(self.girl?.email)
        }
        else
        {
            var nextVC = segue.destination as? RootVC
        }
    }
}
