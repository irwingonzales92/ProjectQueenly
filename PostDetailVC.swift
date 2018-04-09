//
//  PostDetailVC.swift
//  
//
//  Created by Irwin Gonzales on 10/20/17.
//

import UIKit
import CoreData
import Firebase
import Stripe

enum MakingOffer
{
    case offerMaking, offerAccepting
}

protocol PostDetailVCDelegate
{
    func didSetPostType() -> MakingOffer
}

class PostDetailVC: UIViewController
{
//    var collectionView = UICollectionView()
    
    var makingOfferValue = MakingOffer.offerMaking
    
    var delegate: PostDetailVCDelegate?
    
    var recievedGown = [String:Any?]()
    var offeredGown = [String:Any]()
    var collectionView: UICollectionView!
    var cell = UICollectionViewCell()
    
    @IBOutlet weak var measurementsBtn: UIButton!
    @IBOutlet var offerBtn: UIButton!
    var offerDressArray = [[String:Any?]]()
    var gown: [String: Any]?

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var designerLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceTwoLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
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
        
        self.makingOfferValue = (delegate?.didSetPostType())!
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
        let window = UIWindow(frame: UIScreen.main.bounds)
        let settingsVC = SettingsViewController()
        
        if self.makingOfferValue.hashValue == 0
        {
            self.offerBtn.setTitle("Make Offer", for: .normal)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
            present(profileVC!, animated: true, completion: nil)
            
            NotificationCenter.default.post(name: FROM_POST_DETAIL_VC, object: nil)
        }
        else
        {
            self.offerBtn.setTitle("Accept Offer", for: .normal)
            
            
            let checkoutViewController = CheckoutViewController(product: gown!["title"] as! String,
                                                                price: gown!["price"] as! Int,
                                                                settings: settingsVC.settings) as CheckoutViewController
            self.navigationController?.pushViewController(checkoutViewController, animated: true)
        }
        
    }
    
    func initializeStuff()
    {
        
        let imagesID = self.recievedGown["image"] as! Data
        let decodedimage = UIImage(data: imagesID)!
        
        let nameString = self.recievedGown["title"] as! String
        let colorText = self.recievedGown["color"] as! String
//        let shilouetteText = self.recievedGown["shilouette"] as! String
        
        // Int Values
        let priceValue = self.recievedGown["priceOne"] as! Int
        let priceString = String(describing: priceValue)
        print(priceString)
        
        let priceTwoValue = self.recievedGown["priceTwo"] as! Int
        let priceTwoString = String(describing: priceTwoValue)
        print(priceString)

        
        self.priceLabel.text = "$: \(priceString)"
        self.priceLabel.text = "$: \(priceTwoString)"
        self.designerLabel.text = self.recievedGown["poster"] as? String
        self.colorLabel.text = colorText
        self.descriptionLabel.text = self.recievedGown["poster"] as? String
        

    
    }
    
    @IBOutlet weak var measurementBtnPressed: UIButton!
    func setupView()
    {
        self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any)
    {
         dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkMeasurementSegue"
        {
            let nextVC = segue.destination as? MeasurementsVC
            nextVC?.recievedGown = self.recievedGown
        }
    }
}



