//
//  PostDetailVC.swift
//  
//
//  Created by Irwin Gonzales on 10/20/17.
//

import UIKit
import CoreData

class PostDetailVC: UIViewController
{
//    var collectionView = UICollectionView()
    var recievedGown = [String:Any?]()
    var offeredGown = [String:Any]()
    var collectionView: UICollectionView!
    var cell = UICollectionViewCell()
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var offerBtn: UIButton!
    var offerDressArray = [[String:Any?]]()
    var gown = Gown()

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var designerLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var shilouetteLabel: UILabel!
    @IBOutlet var waistLabel: UILabel!
    @IBOutlet var bustLabel: UILabel!
    @IBOutlet var hipLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    var id = String()
    
    @IBOutlet var itemDesignerLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.id = recievedGown["key"] as! String
        print(self.id)
        print("recieved gown")
        
        self.updateUI()
        self.setupView()
        
    }
    
    func updateUI()
    {
        NotificationCenter.default.addObserver(forName: WARDROBE_OFFER, object: nil, queue: OperationQueue.main) { (notification) in
            self.offeredGown = notification.userInfo as! [String:Any]
            print("Offered Gown Recently Passed: \(self.offeredGown)")
            self.offerDressArray.append(self.offeredGown)
            
            NotificationCenter.default.addObserver(forName: VIEW_DRESS_POST, object: nil
                , queue: OperationQueue.main, using: { (notification) in
                    self.offerBtn.titleLabel?.text = "nil"
            })
            
            storageRef.whereField("key", isEqualTo: self.id).getDocuments(completion: { (snapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(err)")
                }
                else
                {
                    print("No Error")
                    for document in snapshot!.documents
                    {
                        print("Document: \(document)")
                        
                        //                        storageRef.whereField("key", isEqualTo: self.id).setValue(self.offerDressArray, forKeyPath: "wardrobeOffers")
                        
                        storageRef.document(document.documentID).updateData(["wardrobeOffers":self.offerDressArray], completion: { (err) in
                            if err == nil
                            {
                                print(document.documentID)
                                print("everything is good")
                                print(self.offerDressArray.count)
                                print("Receieved Gown: \(self.id)")
                                print("Offered Gown: \(self.offeredGown)")
                            }
                            else
                            {
                                print("Error: \(err?.localizedDescription)")
                            }
                        })
                    }
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        self.initializeStuff()
//        NotificationCenter.default.addObserver(forName: FROM_ISOOFFER_VC, object: nil, queue: OperationQueue.main) { (notificaiton) in
//
//            self.offerBtn.titleLabel?.text = "Accept"
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeBtnTitle), name: FROM_ISOOFFER_VC, object: nil)
    }
    
    @objc func changeBtnTitle()
    {
        self.offerBtn.titleLabel?.text = "Accept"
    }

    
    @IBAction func offerBtnPressed(_ sender: Any)
    {
        
        if self.offerBtn.titleLabel?.text == "Offer"
        {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
            present(profileVC!, animated: true, completion: nil)
            
            NotificationCenter.default.post(name: FROM_POST_DETAIL_VC, object: nil)
        }
        
    }
    
    func initializeStuff()
    {
        
        let imagesID = self.recievedGown["image"] as! Data
        let decodedimage = UIImage(data: imagesID)!
        
        let nameString = self.recievedGown["designer"] as! String
        let colorText = self.recievedGown["color"] as! String
        let shilouetteText = self.recievedGown["shilouette"] as! String
        
        // Int Values
        let priceValue = self.recievedGown["price"] as! Int
        let priceString = String(describing: priceValue)
        print(priceString)
        
        let hipValue = self.recievedGown["hip"] as! Int
        let hipString = String(describing: hipValue)
        
        let bustValue = self.recievedGown["bust"] as! Int
        let bustString = String(describing: bustValue)
        
        let waistValue = self.recievedGown["waist"] as! Int
        let waistString = String(describing: waistValue)
        
        let sizeValue = self.recievedGown["size"] as! Int
        let sizeString = String(describing: sizeValue)
        
        self.designerLabel.text = nameString
        self.imageView.image = decodedimage
        self.colorLabel.text = colorText
        self.shilouetteLabel.text = shilouetteText
        
        self.priceLabel.text = "$: \(priceString)"
        
        self.waistLabel.text = waistString
        
        self.bustLabel.text = bustString
        self.hipLabel.text = hipString
        self.sizeLabel.text = sizeString
        
//        NotificationCenter.default.post(name: FROM_POST_DETAIL_VC, object: self.recievedGown)
        
//        print(self.itemDesignerLabel.text)
    }
    
    func setupView()
    {
        self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any)
    {
         dismiss(animated: true, completion: nil)
    }
}



