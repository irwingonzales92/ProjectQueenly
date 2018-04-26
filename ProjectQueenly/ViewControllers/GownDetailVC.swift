//
//  GownDetailViewController.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/12/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

enum DetailType
{
    case iso, wardrobe
}

enum UserAction
{
    case viewingOffer, makingOffer, acceptingOffer, confirmingPost, viewingPost
}

protocol GownDetailVCDelegate
{
    func didSetPostType() -> UserAction
}

class GownDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NextBtnTVCellDelegate {
    
    var gownData = [String:Any]()
    
    var postType = DetailType.iso
    var userAction = UserAction.viewingOffer
    
    var imageData = Data()
    var image = UIImage()
    var price = Int()
    var price2 = Int()
    var gownTitle = String()
    var poster = String()
    var color = String()
    var gownDescription = String()
    var key = String()
    
    var nextBtnCell = NextBtnTVCell()
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(gownData)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.notificationObservers()
        

//        self.nextBtnCell.delegate = self
    }
    
    func unloadDictionary(dict: [String:Any])
    {
        self.imageData = dict["image"] as! Data
        let image = UIImage(data: self.imageData)
        
        self.price = dict["priceRangeOne"] as! Int
        self.gownTitle = dict["title"] as! String
        self.poster = dict["poster"] as! String
        self.color = dict["color"] as! String
        self.gownDescription = dict["description"] as! String
    }
    
    @IBAction func didExitViewOnBtnPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func notificationObservers()
    {
        
        // Notification coming from AddPostVC after clicking call to action
        NotificationCenter.default.addObserver(forName: USER_CONFIRMING_POST, object: nil, queue: OperationQueue.main) { (note) in
            self.userAction = .confirmingPost
            print(" confirming Iso Action \(self.userAction)")
        }
        
        // Notification coming from ProfileVC after clicking "view" button
        NotificationCenter.default.addObserver(forName: USER_VIEWING_OFFER, object: nil, queue: OperationQueue.main) { (note) in
            self.userAction = .viewingOffer
            print(" viewing offer Action \(self.userAction)")
        }
        
        // Notification coming from THIS VC after clicking call to action when offer is set to "viewing post"
        NotificationCenter.default.addObserver(forName: USER_MAKING_OFFER, object: nil, queue: OperationQueue.main) { (note) in
            self.userAction = .makingOffer
            print(" making offer Action \(self.userAction)")
        }
        
        // Notification coming from THIS VC after clicking call to action when offer is set to "viewing offer"
        NotificationCenter.default.addObserver(forName: USER_ACCEPTING_OFFER, object: nil, queue: OperationQueue.main) { (note) in
            self.userAction = .acceptingOffer
            print(" accepting offer Action \(self.userAction)")
        }
        
        // Notification coming from RootVC after clicking post cell
        NotificationCenter.default.addObserver(forName: USER_VIEWING_POST, object: nil, queue: OperationQueue.main) { (note) in
            self.userAction = .viewingPost
            print(" viewing post Action \(self.userAction)")
        }
    }

    // Helper Functions
    func transformImageToDataString(image:UIImage) -> Data
    {
        let metaData = UIImagePNGRepresentation(image)
        
        return metaData!
    }
    
    // Call To Action Btn Delegate Methods
    func didSetGownParams()
    {
        storageRef.document().setData(self.gownData)
        NotificationCenter.default.post(name: ISO_POST, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func isAcceptingOffer() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        self.present(profileVC, animated: true, completion: nil)
    }
    
    func isMakingOffer() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        self.present(profileVC, animated: true, completion: nil)
    }
    
    func isViewingPost() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        self.present(profileVC, animated: true, completion: nil)
    }
    
    // TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! GownImageTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! GownTitleTVCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "priceCell") as! GownPriceAndPosterTvCell
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "colorCell") as! ColorTVCell
        let cell5 = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! GownDescriptionTVCell
        let cell6 = tableView.dequeueReusableCell(withIdentifier: "measurementCell") as! GownMeasurementBtnTVCell
        let cell7 = tableView.dequeueReusableCell(withIdentifier: "actionCell") as! NextBtnTVCell
        
        switch indexPath.row
        {
        case 0:
            cell1.gownImageView?.image = self.image
            return cell1
        case 1:
            cell2.titleLabel?.text = self.gownData["title"] as! String
            return cell2
        case 2:
            cell3.priceLabel.text = String(self.price)
            cell3.posterLabel.text = String(self.price2)
            // amitiitm2009@gmail.com
            return cell3
        case 3:
            cell4.colorLabel.text = self.gownData["color"] as! String
            return cell4
        case 4:
            cell5.decsriptionTextView.text = self.gownDescription
            return cell5
        case 5:
            return cell6
        case 6:
            cell7.delegate = self
            return cell7
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row
        {
            case 0:
                return 300
            case 1:
                return 50
            case 2:
                return 50
            case 3:
                return 45
            case 4:
                return 100
            case 5:
                return 50
            case 6:
                return 60
            
            default:
                return 45
        }
    }
    
    
    
    /////////////////////////
    /////////////////////////
    // Did make offer func //
    /////////////////////////
    /////////////////////////
    
//    func didMakeOffer()
//    {
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        let settingsVC = SettingsViewController()
//
//        if self.makingOfferValue.hashValue == 0
//        {
//            self.offerBtn.setTitle("Make Offer", for: .normal)
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
//            present(profileVC!, animated: true, completion: nil)
//
//            NotificationCenter.default.post(name: FROM_POST_DETAIL_VC, object: nil)
//        }
//        else
//        {
//            self.offerBtn.setTitle("Accept Offer", for: .normal)
//
//
//            let checkoutViewController = CheckoutViewController(product: gown!["title"] as! String,
//                                                                price: gown!["price"] as! Int,
//                                                                settings: settingsVC.settings) as CheckoutViewController
//            self.navigationController?.pushViewController(checkoutViewController, animated: true)
//        }
//
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

/////////////////////////
/////////////////////////
// MVVM IMPLEMENTATION //
/////////////////////////
/////////////////////////

//extension PostConfirmVC: UITableViewDelegate, UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (gownArray != nil) {
//            return gownArray!.count
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let userDisplayNameCell = tableView.dequeueReusableCell(withIdentifier: "userDisplayNameCell", for: indexPath) as! UserDisplayNameCell
//        let gownPriceCell = tableView.dequeueReusableCell(withIdentifier: "gownPriceCell", for: indexPath) as! GownPriceTableViewCell
//        let gownColorCell = tableView.dequeueReusableCell(withIdentifier: "gownColorCell", for: indexPath) as! GownColorTableViewCell
//        let gownDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "gownDescriptionCell", for: indexPath) as! GownDescriptionTableViewCell
//
//        if (gownArray != nil) {
//            let gownItem = self.gownArray![indexPath.row]
//
//            switch gownItem.type
//            {
//            case .displayName:
//                userDisplayNameCell.configure(with: gownItem as! GownDataDisplayItem)
//                return userDisplayNameCell
//            case .price:
//                gownPriceCell.configure(with: gownItem as! GownDataPriceItem)
//                return gownPriceCell
//            case .color:
//
//                gownColorCell.configure(with: gownItem as! GownDataColorItem)
//                return gownColorCell
//
//            case .description:
//                gownDescriptionCell.configure(with: gownItem as! GownDataDescriptionItem)
//                return gownDescriptionCell
//            }
//        }
//
//        return UITableViewCell()
//
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//}

