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
    
    var girl: Girl?
    
    
//    func registerUser(withEmail email:String, Password password:String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
//    {
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            guard user != nil else {
//                userCreationComplete(false, error)
//                return
//            }
//
//            let userData = ["provider": user?.providerID, "userEmail": user?.email, "userId": Auth.auth().currentUser?.uid] as [String: Any]
//
//            self.girl = Girl(designer: nil, shilouette: nil, color: nil, image: nil, name: nil, uid: user?.uid, email: user?.email, displayName: nil, size: nil, waist: nil, bust: nil, hip: nil, height: nil, onboarded: false)
//            DataService.instance.createFirestoreUser(uid: user!.uid, userData: userData)
//            userRef.document().setModel(self.girl!)
//            print("User Created")
//            userCreationComplete(true, nil)
//        }
//    }
    
    func registerUser(withEmail email:String, Password password:String, DisplayName username: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
    {
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            guard user != nil else {
                userCreationComplete(false, err)
                return
            }
            let userData = ["provider": user?.providerID, "email":user?.email, "username":user?.displayName, "uid":user?.uid]
            userRef.document().setValue(user?.uid, forKey: "uid")
            userRef.document().setData(userData)
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
