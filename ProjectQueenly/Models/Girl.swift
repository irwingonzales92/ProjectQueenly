//
//  Girl.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 11/6/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct Girl {
        
    //Prefrences
    var designer: String?
    var shilouette: String?
    var color: String?
    
    //Profile
    var image: Data?
    var name: String?
    var uid: String?
    var email: String?
    var displayName: String?
    
    //Measurements
    var size: Int?
    var waist: Int?
    var bust: Int?
    var hip: Int?
    var height: Int?
    
    //Payment Info
    
    var onboarded = Bool()
    
    enum UserType: String, StringRawRepresentable
    {
        case poster, shopper
    }
    
}

extension Girl: FirestoreModel {
    
    init?(modelData: FirestoreModelData)
    {

        try? self.init(designer: modelData.value(forKey: "designer"), shilouette: modelData.value(forKey: "shilouette"), color: modelData.value(forKey: "color"), image: modelData.value(forKey: "image"), name: modelData.value(forKey: "designer"), uid: modelData.value(forKey: "uid"), email: modelData.value(forKey: "email"), displayName: modelData.value(forKey: "displayName"), size: modelData.value(forKey: "size"), waist: modelData.value(forKey: "waist"), bust: modelData.value(forKey: "bust"), hip: modelData.value(forKey: "hip"), height: modelData.value(forKey: "height"),
                       onboarded: modelData.value(forKey: "onborded")
        )
    }
    
    var documentID: String!
    {
        return "uid"
    }
    
    var customID: String?
    {
        return "uid"
    }
    
}


