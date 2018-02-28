//
//  PostConfirmVC.swift
//  ProjectQueenly
//

//  Created by Irwin Gonzales on 11/12/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase

class PostConfirmVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var waistLabel: UILabel!
    @IBOutlet var bustLabel: UILabel!
    @IBOutlet var hipLabel: UILabel!
    @IBOutlet var designerLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var shilouetteLabel: UILabel!
    @IBOutlet var postBtn: UIButton!
    
    var data = [String: Any]()
    var dressArray = [String]()
    
    var designer = String()
    var size = Int()
    var price = Int()
    var shilouette = String()
    var color = String()
    var waist = Int()
    var bust = Int()
    var hip = Int()
    var image = UIImage()
    var key = String()
    var poster = String()
    var wardrobe = Bool()
    
    var storageRef = Firestore.firestore().collection("Dress")
    var userRef = Firestore.firestore().collection("Users")

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print("Object Passed")
        print(self.key)
        
//        NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
//        print(self.data.keys)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.openDictionary(dict: data)
        self.setStuff()
    }
    
    func openDictionary(dict: [String: Any])
    {
        self.bust = dict["bust"] as! Int
        self.hip = dict["hip"] as! Int
        self.size = dict["size"] as! Int
        self.price = dict["price"] as! Int
        self.color = dict["color"] as! String
        self.shilouette = dict["shilouette"] as! String
        self.designer = dict["designer"] as! String
        self.color = dict["color"] as! String
        self.image = dict["image"] as! UIImage
        self.wardrobe = dict["isWardrobe"] as! Bool
    }
    
    func setStuff()
    {
        self.designerLabel.text = self.designer
        self.shilouetteLabel.text = self.shilouette
        self.colorLabel.text = self.color
        self.imageView.image = self.image
        self.poster = (Auth.auth().currentUser?.uid)!
        
        let sizeString = String(self.size)
        self.sizeLabel.text = sizeString
        
        let priceString = String(self.price)
        self.priceLabel.text = priceString
        
        let waistString = String(self.waist)
        self.waistLabel.text = waistString
        
        let hipString = String(self.hip)
        self.hipLabel.text = hipString
        
        let bustString = String(self.bust)
        self.bustLabel.text = bustString
        
    }
    
    func transformImageToDataString()
    {
        let metaData = UIImagePNGRepresentation(self.imageView.image!)
        self.data.updateValue(metaData, forKey: "image")
    }
    
    func addWardrobeToUser(poster: String, dress: [String: Any])
    {
        print(dress)
        print(poster)
        self.userRef.document(poster).updateData(dress)
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBtnPressed(_ sender: Any)
    {
        self.transformImageToDataString()
        
        self.storageRef.addDocument(data: self.data) { (error) in
            if error != nil
            {
                print("Error Saving To Storage")
                debugPrint(error?.localizedDescription ?? String())
                self.presentAlertController(error: error?.localizedDescription ?? String())
            }
            else
            {
                print("Saved!!")
                print(self.poster)
        //                print("\(document.documentID) => \(document.data())")
//                self.dismiss(animated: true, completion: nil)

                NotificationCenter.default.post(name: ISO_POST, object: nil)
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "RootVC") as? RootVC
                self.present(homeVC!, animated: true, completion: nil)
            }
//            DataService.instance.addWardrobeToUser(dress: ["Dresses": self.dressArray])
            self.dressArray.append(self.key)
            DataService.instance.addWardrobeToUser(poster: self.poster, dress: ["Dresses":self.dressArray])
        }
        
        
        
//        DataService.instance.createFirestoreDress(dressData: self.data) { (completed, err) in
//            if err != nil
//            {
//                print("Error Saving To Storage")
//                debugPrint(err?.localizedDescription ?? String())
//                self.presentAlertController(error: err?.localizedDescription ?? String())
//            }
//            else
//            {
//                print("Saved!!")
//                print(self.poster)
//                //                print("\(document.documentID) => \(document.data())")
//                //                self.dismiss(animated: true, completion: nil)
//
//                NotificationCenter.default.post(name: ISO_POST, object: nil)
////                DataService.instance.addWardrobeToUser(dress: self.key)
//                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                let homeVC = storyboard.instantiateViewController(withIdentifier: "RootVC") as? RootVC
//                self.present(homeVC!, animated: true, completion: nil)
//            }
//
//        DataService.instance.addWardrobeToUser(dress: self.key)
//        }
    }
    
    func presentAlertController(error:String)
    {
        let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

}

