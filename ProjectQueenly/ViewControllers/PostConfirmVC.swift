//
//  PostConfirmVC.swift
//  ProjectQueenly
//

//  Created by Irwin Gonzales on 11/12/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase

enum GownElementType: String
{
    case displayName, price, color, description
}

protocol GownElement
{
    var type: GownElementType {get}
}

protocol CustomElementCell {
    func configure(withGown: Gown)
}

class PostConfirmVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var designerLabel: UILabel!
    @IBOutlet var postBtn: UIButton!
    
    var girl: Girl?
    var gown: Gown?
        
    var data = [String: Any]()
    var dressArray = [String]()
    @IBOutlet var tableView: UITableView!
    
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
    
    var gownArray: [GownDataViewModelItem]?
    
    var storageRef = Firestore.firestore().collection("Dress")
    var userRef = Firestore.firestore().collection("Users")

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("Object Passed")
        print(self.gown?.documentID ?? "")
        print(self.gownArray)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
        
        // save for optimizing
//        self.tableView.dataSource = GownViewModel() as UITableViewDataSource
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.setStuff()
    }
    
    func openGownObj(gown: Gown)
    {
        
    }
    
    func saveDressToDB(savingGown: Gown)
    {
    self.storageRef.document(savingGown.documentID).setModel(savingGown)
    }
//
    func setStuff()
    {
        self.designerLabel.text = self.gown?.title


    }
    
    func transformImageToDataString()
    {
        
        if (self.imageView.image != nil) {
            let metaData = UIImagePNGRepresentation(self.imageView.image!)
            self.data.updateValue(metaData!, forKey: "image")
        }
        
    }
    
    
    ///////// YOU ARE TRYING TO CONVERT STRING TO IMAGE
    func transferDataStringToImage()
    {
        let encodedData = self.gown?.image
        let decodedimage = UIImage(data: encodedData!)
        self.imageView.image = decodedimage
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
        self.saveDressToDB(savingGown: self.gown!)
//        self.storageRef.document((self.gown?.documentID)!).setModel(self.gown!)
        
//        self.storageRef.addDocument(data: self.data) { (error) in
//            if error != nil
//            {
//                print("Error Saving To Storage")
//                debugPrint(error?.localizedDescription ?? String())
//                self.presentAlertController(error: error?.localizedDescription ?? String())
//            }
//            else
//            {
//                print("Saved!!")
//                print(self.poster)
//        //                print("\(document.documentID) => \(document.data())")
////                self.dismiss(animated: true, completion: nil)
//
//                NotificationCenter.default.post(name: ISO_POST, object: nil)
//                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                let homeVC = storyboard.instantiateViewController(withIdentifier: "RootVC") as? RootVC
//                self.present(homeVC!, animated: true, completion: nil)
//            }
////            DataService.instance.addWardrobeToUser(dress: ["Dresses": self.dressArray])
//            self.dressArray.append(self.key)
//            DataService.instance.addWardrobeToUser(poster: self.poster, dress: ["Dresses":self.dressArray])
//        }
        
        
        
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


extension PostConfirmVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (gownArray != nil) {
            return gownArray!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userDisplayNameCell = tableView.dequeueReusableCell(withIdentifier: "userDisplayNameCell", for: indexPath) as! UserDisplayNameCell
        let gownPriceCell = tableView.dequeueReusableCell(withIdentifier: "gownPriceCell", for: indexPath) as! GownPriceTableViewCell
        let gownColorCell = tableView.dequeueReusableCell(withIdentifier: "gownColorCell", for: indexPath) as! GownColorTableViewCell
        let gownDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "gownDescriptionCell", for: indexPath) as! GownDescriptionTableViewCell
        
        if (gownArray != nil) {
            let gownItem = self.gownArray![indexPath.row]
            
            switch gownItem.type
            {
            case .displayName:
                userDisplayNameCell.configure(with: gownItem as! GownDataDisplayItem)
                return userDisplayNameCell
            case .price:
                gownPriceCell.configure(with: gownItem as! GownDataPriceItem)
                return gownPriceCell
            case .color:
                
                gownColorCell.configure(with: gownItem as! GownDataColorItem)
                return gownColorCell
                
            case .description:
                gownDescriptionCell.configure(with: gownItem as! GownDataDescriptionItem)
                return gownDescriptionCell
            }
        }
        
        return UITableViewCell()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
