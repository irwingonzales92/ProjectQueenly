//
//  AuthService.swift
//  HangSwift
//
//  Created by Irwin Gonzales on 8/21/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import Firebase

class AuthService
{
    static let instance = AuthService()
    
    func registerUser(withEmail email:String, Password password:String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
    {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard user != nil else {
                userCreationComplete(false, error)
                return
            }

            let userData = ["provider": user?.providerID, "userEmail": user?.email, "userId": Auth.auth().currentUser?.uid] as [String: Any]
            DataService.instance.createFirestoreUser(uid: user!.uid, userData: userData)
            print("User Created")
            userCreationComplete(true, nil)
        }
    }
//
    func loginUser(withEmail email:String, andPassword password:String, userLoginComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
    {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard user != nil else{
                userLoginComplete(false, error)
                return
            }
            userLoginComplete(true, error)
            print("User SignedIn")

        }
    }
    
}