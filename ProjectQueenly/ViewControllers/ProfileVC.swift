//
//  ProfileVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import RxSwift

class ProfileVC: UIViewController, AddPostVCDelegate
{
    func didSetPostType() -> State {
        return wardrobePost.value
    }
    
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    enum makingOffer
    {
        case isMakingOffer
    }
    
    let wardrobePost = Variable<State>(.wardrobe)
    var selectedType: Observable<State> {
        return wardrobePost.asObservable()
    }
    
    var gowns = [[String:Any]]()
    var gown = [String: Any?]()
    var recievedGown = [String:Any?]()
    var offeringArray: [[String: Any]]?
    
    
    @IBOutlet var tabBarNameLabel: UILabel!
    @IBOutlet var addToWardrobeBtn: UIButton!
    
    var girl = Girl()
    
    
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
    var poster = String()
    var wardrobe = Bool()
    var cell = WardrobeCVC()
    var makingOffer = Bool()
    
    
    var dressStorageRef = Firestore.firestore().collection("Dress")
    var userRef = Firestore.firestore().collection("Users").document((Auth.auth().currentUser?.uid)!)
    
    var user = Auth.auth().currentUser
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.updateUI()
    }
    
    func updateUI()
    {
        self.initalizeStuff()
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(setWardrobeParams), name: FROM_POST_DETAIL_VC, object: nil)
        
//        self.userRef.setModel
        
        NotificationCenter.default.addObserver(forName: FROM_POST_DETAIL_VC, object: nil, queue: OperationQueue.main) { (notification) in
            self.makingOffer = true
            
            if self.makingOffer != true
            {
                print("Error in making offer")
                
            }
            else
            {
                print("Offer Made")
                
                var note = notification.object as? String
                note = self.recievedGown["id"] as? String
                //                print(note)
            }
        }
    }
    
    @objc func setWardrobeParams()
    {
        
    }
    
    @objc func makingIsoOffer()
    
    {
        self.makingOffer = true

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        
//        self.pullUserProfileDress()
        
    }
    func initalizeStuff()
    {
        self.collectionView.delegate = self as! UICollectionViewDelegate
        self.collectionView.dataSource = self as! UICollectionViewDataSource
    }
    
    func pullUserProfileDress()
    {
        var poster = String()
        var documentID = String()
        
        storageRef.getDocuments() { (querySnapshot, err) in
            if let err = err
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                for document in querySnapshot!.documents
                    {
                        let documentData = document.data()
//                        print(documentData)
                        
                        if document != nil
                        {
                            poster = documentData["poster"] as! String
                            //                        print(poster)
                            
                            if Auth.auth().currentUser?.uid == poster
                            {
                                self.gowns.append(documentData)
                                print("No Error, Dresses are in the Array!")
                                self.collectionView.reloadData()
                            }
                        }
                        else
                        {
                            print("Nothing here! \(documentData)")

                        }
                    }
                }
            }
    }

    
    @IBAction func backBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addToWardrobeBtnPressed(_ sender: Any)
    {
        if self.makingOffer == true
        {
            let alert = UIAlertController(title: "Do You Want To Make This Offer", message: "You will be offering the dresses you selected", preferredStyle: .alert)
            
            let acceptAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                self.addWardrobeToIsoOffer()
            }
            alert.addAction(acceptAction)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let postVC = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as? AddPostVC
            
            postVC?.delegate = self
            print("Post Type Value: \(wardrobePost.value)")
            
            present(postVC!, animated: true, completion: nil)
        }
    }
}

extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gowns.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        self.cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WardrobeCVC
        
        self.gown = gowns[indexPath.row]
        self.cell.designerLabel.text = self.gown["designer"] as? String
        self.cell.backgroundColor = UIColor.red
        
        let imagesID = gown["image"] as? Data
        let decodedimage = UIImage(data: imagesID!)
        self.cell.imageView.image = decodedimage
        
        
        
        return self.cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        gown = gowns[indexPath.row]
        if self.makingOffer == true
        {
            self.cell.checkedBtnImgView.image = UIImage(named: "icons8-Checked Filled-50")
            offeringArray?.append(gown)
            
            print("offer made")
            
//            self.addWardrobeToIsoOffer()            
            NotificationCenter.default.post(name: WARDROBE_OFFER, object: nil, userInfo: self.gown)
            
        }
        else
        {
            print("error")
        }
    }
    
    func addWardrobeToIsoOffer()
    {
        if self.makingOffer == true
        {
            let dressId = self.recievedGown["id"] as! String
            print(dressId)
            var offeredDress = [[String:Any?]]()
            
            offeredDress.append(self.gown)
            
            dressStorageRef.document(dressId).setValue(offeringArray, forKeyPath: "isooffers")
        }
        
        NotificationCenter.default.post(name: WARDROBE_OFFER, object: nil, userInfo: self.gown)
    }
}


