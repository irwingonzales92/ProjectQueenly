//
//  BackendStuff.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 12/31/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import Firebase

class BackendStuff
{
    static let instance = BackendStuff()
    
    var poster = String()
    var documentId = String()
    var dressArray = [String]()
    var gownDict = [[String:Any]]()
    var user: Girl?
    var closet: [Gown]?
    var dress: Gown?
    
    var postState: State?
    
    func insertDressToOwner()
    {
        var poster = String()
        var documentId = String()
        
        var dressArray = [String]()
        
        
        storageRef.getModels(Gown.self) { (closet, err) in
            guard let pulledCloset = closet else {return}

            self.closet = closet

            userRef.document((Auth.auth().currentUser?.uid)!).getModel(Girl.self) { (girl, err) in
                guard let pulledGirl = girl else {return}

                self.user = pulledGirl
                
                if Auth.auth().currentUser?.uid != self.user?.documentID && self.closet?.count == 0
                {
                    debugPrint("error")
                }
                else
                {
                    userRef.document((self.user?.documentID)!).setModel(self.closet as! FirestoreModel)
                }
            }
        }
        
//            userRef.document((Auth.auth().currentUser?.uid)!).getModel(Girl.self) { (girl, err) in
//                guard let pulledGirl = girl else {return}
//
//                self.user = pulledGirl
//
//            }
//
//        }
    
//        storageRef.getDocuments() { (querySnapshot, err) in
//            if let err = err
//            {
//                print("Error getting documents: \(err)")
//            }
//            else
//            {
//                for document in querySnapshot!.documents
//                {
//                    //                    print("\(document.documentID) => \(document.data())")
//                    let documentData = document.data()
//
//                    
//
//                    poster = documentData["poster"] as! String
//                    documentId = documentData["key"] as! String
//
//                    if Auth.auth().currentUser?.uid == poster
//                    {
//                        dressArray.append(documentId)
//                        print(dressArray)
////                        userRef.document((Auth.auth().currentUser?.uid)!).setValue(dressArray, forKeyPath: "Dresses")
//                        userRef.document((Auth.auth().currentUser?.uid)!).updateData(["Dresses" : dressArray], completion: { (err) in
//                            if err == nil
//                            {
//                                print("Save is good")
//                            }
//                            else
//                            {
//                                print(err?.localizedDescription ?? String())
//                            }
//                        })
//                    }
//
//                    print(poster)
//                    print(documentId)
//                }
//            }
//        }
//    }
    
//    func pullUserProfileDress(dataArray: [[String:Any]])
//    {
//
//        let userUID = Auth.auth().currentUser!.uid
//
//        storageRef.whereField("poster", isEqualTo: userUID).getDocuments { (snapshot, err) in
//            if let err = err
//            {
//                print("Error in fetching dress")
//
//            }
//            else
//            {
//                for document in snapshot!.documents
//                {
//                    let documentData = document.data()
//                    dataArray.append(documentData)
//                    print(dataArray.count)
//                    print("No Error, Dresses are in the Array!")
//                }
//            }
//
//        }
    
//        storageRef.getDocuments() { (querySnapshot, err) in
//            if let err = err
//            {
//                print("Error getting documents: \(err)")
//            }
//            else
//            {
//                for document in querySnapshot!.documents
//                {
//                    //                    print("\(document.documentID) => \(document.data())")
//                    let documentData = document.data()
//
//                    poster = documentData["poster"] as! String
//                    documentId = documentData["id"] as! String
//
//                    if Auth.auth().currentUser?.uid == poster
//                    {
//                        dressArray.append(documentId)
//                        print(dressArray)
//                        print(poster)
//                        print(documentId)
//                        print("No Error, Dresses are in the Array!")
//                    }
//                }
//            }
//        }
//        return dressArray
//    }
    
    func pullDressFromString(dressId: String) -> [[String:Any]]
    {
        
        storageRef.getDocuments { (snapshot, err) in
            if err == nil
            {
                for document in (snapshot?.documents)!
                {
                    let documentData = document.data()
                    if dressId == documentData["id"] as! String
                    {
                        self.gownDict.append(documentData)
                    }
                    else
                    {
                        print("Error in printing object")
                    }
                }
            }
            else
            {
                print("Error In Getting Documents")
            }
        }
        return self.gownDict
    }
        
    func setDressType(state: State) -> State
    {
        switch state
        {
            case .ISO:
                return state
            case .wardrobe:
                return state
        }
    }
        
    func transformImageToDataString(image: UIImage, data:[String: Any]) 
    {
        var secondData = [String: Any]()
        let metaData = UIImagePNGRepresentation(image)
        secondData.updateValue(metaData, forKey: "image")
        secondData = data
    }

  }
}
