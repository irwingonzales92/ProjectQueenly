//
//  DataService.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import Firebase
import CoreData

let DB_BASE = Database.database().reference()
let FRS_BASE = Firestore.firestore()
var storageRef = Firestore.firestore().collection("Dress")
var userRef = Firestore.firestore().collection("Users")

var DC_REF: DocumentReference!

//// Get a reference to the storage service using the default Firebase App
//let storage = Storage.storage()
//
//
//// Create a storage reference from our storage service
//let storageRef = storage.reference()

class DataService
{
    static let instance = DataService()
    var userSnapshot: DataSnapshot?
    private var _REF_BASE = DB_BASE
    private var _DOC_REF = DC_REF
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_DRESS = DB_BASE.child("dress")
    private var _REF_FEED = DB_BASE.child("feed")
    
    private var _FRS_DRESS = FRS_BASE.collection("Dress")
    private var _FRS_USERS = FRS_BASE.collection("Users")
    
    
    var DOC_REF: DocumentReference?
    {
        return _DOC_REF
    }
    
    var REF_BASE: DatabaseReference
    {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference
    {
        return _REF_USERS
    }
    
    var FRS_USERS: CollectionReference
    {
        return _FRS_USERS
    }
    
    var REF_DRESS: DatabaseReference
    {
        return _REF_DRESS
    }
    
    var FRS_DRESS: CollectionReference
    {
        return _FRS_DRESS
    }
    
//    var REF_FEED: DatabaseReference
//    {
//        return _REF_FEED
//    }
    
//    func createFirebaseDBUsers(uid: String, userData: Dictionary<String, Any>, isLeader: Bool)
//    {
////        REF_USERS.child(uid).updateChildValues(userData)
//
//
//    }
//
//    func createPostOnFirebaseDB(uid: String, userData: Dictionary<String, Any>)
//    {
//        REF_DRESS.child(uid).updateChildValues(userData)
//    }
//
//    func addDressToWardrobe(uid: String, userData: Dictionary<String, Any>)
//    {
//        REF_DRESS.child(uid).updateChildValues(userData)
//    }
    
    func createFirestoreUser(uid: String, userData: Dictionary<String, Any>)
    {
//        FRS_USERS.addDocument(data: userData) { (err) in
//            if err == nil
//            {
//                userCreationComplete(true, nil)
//            }
//            else
//            {
//                debugPrint(err)
//            }
//        }
        
        FRS_USERS.addDocument(data: userData)
    }

    func createFirestoreDress(dressData: Dictionary<String, Any>, dressCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
    {
        FRS_DRESS.addDocument(data: dressData) { (err) in
            if err == nil
            {
                dressCreationComplete(true, nil)
            }
            else
            {
                debugPrint(err)
            }
        }
        
//        FRS_DRESS.addDocument(data: dressData)
    }
    
//    func addPost(userData: Dictionary<String, Any>)
//    {
//        REF_DRESS.updateChildValues(userData)
//        print("save successful")
//        debugPrint(userData)
//    }
    
    func addISODressToUser(user:String)
    {
        FRS_USERS.document(user).setValue(Dictionary<String, Any>(), forKey: "ISODresses")
    }
    
    func addWardrobeToUser(poster: String, dress: [String: Any])
    {
        print(dress)
        print(poster)
//        userRef.document(poster).updateData(dress)
        userRef.document(poster).updateData(dress) { (err) in
            if err == nil
            {
                print("Dress Added To Wardrobe")
            }
            else
            {
                print(err?.localizedDescription ?? String())
            }
        }
    }
}

