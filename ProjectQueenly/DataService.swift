//
//  DataService.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService
{
    static let instance = DataService()
    var userSnapshot: DataSnapshot?
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_DRESS = DB_BASE.child("dress")
    private var _REF_FEED = DB_BASE.child("feed")
    
    
    var REF_BASE: DatabaseReference
    {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference
    {
        return _REF_USERS
    }
    
    var REF_HANGOUT: DatabaseReference
    {
        return _REF_HANGOUT
    }
    
    var REF_FEED: DatabaseReference
    {
        return _REF_FEED
    }
    
    func createFirebaseDBUsers(uid: String, userData: Dictionary<String, Any>, isLeader: Bool)
    {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}

