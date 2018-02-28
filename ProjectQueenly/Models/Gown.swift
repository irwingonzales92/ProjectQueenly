//
//  Gown.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 11/1/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import Firebase

protocol DocuementSerializable {
    init?(dictonary:[String:Any])
}

struct Gown {
    
    var designer = String()
    var size = Int()
    var price = Int()
    var shilouette = String()
    var color = String()
    var waist = Int()
    var bust = Int()
    var hip = Int()
    var image = NSData()
    var key = String()
    
    var dictionary:[String:Any] {
        return [
            "designer":designer,
            "size":size,
            "price":price,
            "shilouette":shilouette,
            "color":color,
            "waist":waist,
            "bust":bust,
            "hip":hip,
            "image":image,
            "key":key
        ]
    }
}

//extension Gown: DocuementSerializable {
//    init?(dictonary: [String : Any]) {
//        guard let designer = dictonary["designer"] as? String,
//            let size = dictonary["size"] as? Int,
//            let price = dictonary["price"] as? Int,
//            let shilouette = dictonary["shilouette"] as? String,
//            let color = dictonary["color"] as? String,
//            let waist = dictonary["waist"] as? Int,
//            let bust = dictonary["bust"] as? Int,
//            let hip = dictonary["hip"] as? Int,
//            let image = dictonary["image"] as? NSData,
//            let key = dictionary["key"] as? String else {
//                return nil
//                
//        }
//    
//        self.init(designer: designer, size: size, price: price, shilouette: shilouette, color: color, waist: waist, bust: bust, hip: hip, image: image, key: key)
//    }
//}

