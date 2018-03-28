//
//  Gown.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 11/1/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Firebase

enum ModelDataValue: String
{
    // User Input properties
    case title = "Title"
    case size = "Size"
    case lowPrice = "LowPrice"
    case highPrice = "HighPrice"
    case description = "Description"
    case color = "Color"
    case condition = "Condition"
    case image = "Image"

    // User Refrenced properties
    case waist = "Waist"
    case bust = "Bust"
    case hip = "Hip"
    case key = "Key"
    case shilouette = "Shilouette"
    
    // Autmoatically Inputed properties
    case isbn = "String"
    case poster = "Poster"
    
    // Misc & Data Types
    case offers = "Offers"
    case postType = "PostType"
}

struct Gown {
    
    var title: String?
    var size: Int?
    var priceRange1: Int?
    var priceRange2: Int?
    var shilouette: String?
    var color: String?
    var waist: Int?
    var bust: Int?
    var hip: Int?
    var image: Data?
    var isbn = String()
    var poster: String?
    var offers: [String]?
    var description: String?
    var condition: String?
    var postType: String?
    
    // Time Stamp Add Into Model After Fixing Flow
//    var timeStampStart: Int?
//    var timeStampEnd: Int?
//
//    var offerCount: Int?
    
    
    enum PostType: String, StringRawRepresentable
    {
        case iso, wardrobe
    }
    
    enum DressCondition: String, StringRawRepresentable
    {
        case unused, excellent, good, okay, wearingdown, damaged
    }
    
    
    
//    func setCondition(input: DressCondition)
//    {
//        switch input
//        {
//            case "unused":
//                    .unused
//                break
//
//            case .excellent:
//                DressCondition.excellent
//                break
//
//            case .good:
//                DressCondition.good
//                break
//
//            case .okay:
//                DressCondition.okay
//                break
//
//            case .wearingdown:
//                DressCondition.wearingdown
//                break
//
//            case .damaged:
//                DressCondition.good
//                break
//        }
//    }
    
//    var postType: PostType

}

extension Gown: FirestoreModel {
    
    init?(modelData: FirestoreModelData)
    {
        try? self.init(title: modelData.value(forKey: ModelDataValue.title.rawValue), size: modelData.value(forKey: ModelDataValue.size.rawValue), priceRange1: modelData.value(forKey: ModelDataValue.highPrice.rawValue), priceRange2: modelData.value(forKey:ModelDataValue.lowPrice.rawValue), shilouette: modelData.value(forKey: ModelDataValue.shilouette.rawValue), color: modelData.value(forKey: ModelDataValue.color.rawValue), waist: modelData.value(forKey: ModelDataValue.waist.rawValue), bust: modelData.value(forKey: ModelDataValue.bust.rawValue), hip: modelData.value(forKey: ModelDataValue.hip.rawValue), image: modelData.value(forKey: ModelDataValue.image.rawValue), isbn: modelData.value(forKey: ModelDataValue.key.rawValue), poster: modelData.value(forKey: ModelDataValue.poster.rawValue), offers: modelData.value(forKey: ModelDataValue.offers.rawValue), description: modelData.value(forKey: ModelDataValue.description.rawValue), condition: modelData.value(forKey: ModelDataValue.condition.rawValue), postType: modelData.value(forKey: ModelDataValue.postType.rawValue)
        )
    }

    var documentID: String!
    {
        return isbn
    }

    var customID: String?
    {
        return "isbn"
    }

}

