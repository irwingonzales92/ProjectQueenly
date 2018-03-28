//
//  RootViewController.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 9/28/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

/*
 
 **** POST RE-WIRE TASK LIST ****
 
 ** To Do Now **
 
 1. Finish establishing user model through onboarding.
 2. Configure Stripe - (Already installed) - HALTED UNTIL ORDERING PROCESS IS COMPLETE
 3. Complete ordering process
 4. Bug Sweep
 
 ---. Done! .---
 
 ** TO-DO Tomororow **
 
 
 */

import UIKit
import CoreData
import RevealingSplashView
import Firebase
import TRMosaicLayout
import AZEmptyState


class RootVC: UIViewController
{
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var postBtn: RoundedShadowButton!
    
    // Object Container Types
//    var gowns = [[String:Any]]()
    var gowns = [Gown]()
    var gownObj: Gown?
    var selectedGown: UIImage?
    var girl: Girl?
    
    // DB Refrence & Delegate
    let appDelegate = AppDelegate.getAppDelegate()
    var delegate: CenterVCDelegate?
    var storageRef = Firestore.firestore().collection("Dress")
    
    // UI Elements
    var refreshControl = UIRefreshControl()
    var cell = PostCVC()
    let mosaicLayout = TRMosaicLayout()
    var alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
    
    
    // Dress Objects
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
    var gown = [String: Any?]()
    
    var emptyStateView = AZEmptyStateView()
    
    // App State
//    fileprivate var state = State.self
    
//    var postDetailVc = PostDetailVC()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name.init(rawValue: "UserLoggedIn"), object: nil)
        
        setUpDelegates()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: ISO_POST, object: nil)
        BackendStuff.instance.insertDressToOwner()
        self.collectionView.reloadData()
    }

    
// Helper Methods
    
    @objc func updateUI()
    {
        if Auth.auth().currentUser == nil
        {
            print("user is not logged in")
            appDelegate.MenuContainerVC.toggleLoginVC()
        }
        else
        {
//            debugPrint(Auth.auth().currentUser?.email as! String)
            //            gowns = self.pullSavedDress()
            
//            userRef.document((Auth.auth().currentUser?.uid)!).setModel(self.girl!)
//            debugPrint(self.girl?.uid)
            debugPrint(self.girl?.email)
            
            self.pullSavedDress()
//            self.gown = self.gownObj.dictionary
            print(gowns.count)
        }
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Crown")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
        
        self.collectionView.isScrollEnabled = true
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControlEvents.valueChanged)
        //        collectionView.addSubview(refreshControl)
        collectionView.refreshControl = self.refreshControl
        
        
        
    }
    
    // * MAKE INTO CUSTOM OBJECT! *
    func displayEmptyStateView()
    {
        // If empty, display the empty message viewcontroller
        
        if self.gowns.count == 0
        {
            //init var
            
            //customize
            self.emptyStateView.image = UIImage.init(named: "sad")!
            self.emptyStateView.message = "No Dresses Up Yet!"
            self.emptyStateView.buttonText = "Search For One!"
            self.emptyStateView.buttonTint = .purple
            self.emptyStateView.addTarget(self, action: #selector(postButtonPressed(_:)), for: .touchUpInside)
            
            self.postBtn.isHidden = true
            
            //add subview
            view.addSubview(emptyStateView)
            
            //add autolayout
            self.emptyStateView.translatesAutoresizingMaskIntoConstraints = false
            self.emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
            self.emptyStateView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55).isActive = true
        }
        else
        {
            debugPrint(self.gowns.count)
            self.collectionView.reloadData()
            self.emptyStateView.removeFromSuperview()
        }
    }
    
    func setUpDelegates()
    {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self as TRMosaicLayoutDelegate
    }
    
    
    func refresh(sender:AnyObject) {
        self.collectionView.reloadData()
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        // Perform actions to refresh the content
        // ...
        // and then dismiss the control
        
        if self.gowns.count != self.gowns.count
        {
            self.pullSavedDress()
            sender.endRefreshing()
        }
        else
        {
            print("No Need")
            sender.endRefreshing()
        }
    }
    
    // PUT INTO A SEPERATE OBJECT
    func pullSavedDress()
    {
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

                    let ref = self.storageRef.document()
                    ref.setModel(self.gownObj!)

                    print(self.gowns.count)
                    self.collectionView.reloadData()
                }
            }
        }
        
//        storageRef.getModels(Gown.self) { (pulledGowns, err) in
//
//            if err == nil
//            {
//                if pulledGowns?.count == 0
//                {
//                    debugPrint("pulledGowns == 0")
//                }
//                else
//                {
//                    for gown in pulledGowns!
//                    {
//                        self.gownObj = gown
//                        self.gowns.append(self.gownObj!)
//                        self.collectionView.reloadData()
//                    }
//                }
//            }
//            else
//            {
//                debugPrint(err?.localizedDescription as! String)
//            }
//        }
    }
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetailVC"
        {
            let nextVC = segue.destination as? PostDetailVC
//            nextVC?.recievedGown = self.gown
            nextVC?.gown = self.gownObj
        }
        else
        {
            NotificationCenter.default.post(name: VIEW_DRESS_POST, object: nil)
            print("View Notification Posted")
        }
     }
    
    // MARK: - Alerts
    
    func displayAlertController(alert: UIAlertController, title: String, message: String?)
    {
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }
    

    
    
//    self.present(alert, animated: true, completion: nil)
 

    // MARK: - Actions
    
    @IBAction func postButtonPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let postVC = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as? AddPostVC
        
        NotificationCenter.default.post(name: FROM_ROOT_VC, object: nil)
        print(FROM_ROOT_VC)
        present(postVC!, animated: true, completion: nil)

    }
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        appDelegate.MenuContainerVC.toggleLeftPanel()        
    }
}

extension RootVC: UICollectionViewDataSource, UICollectionViewDelegate
{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gowns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostCVC
        
        
        self.gownObj = gowns[indexPath.row]
        self.cell.designerLabel.text = self.gown["designer"] as? String
        print(self.cell.designerLabel.text)
        self.cell.backgroundColor = UIColor.red
        
        let imagesID = gown["image"] as? Data
        let decodedimage = UIImage(data: imagesID!)
        self.cell.imageView.image = decodedimage
        
        
        return self.cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 100);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.gownObj = gowns[indexPath.row]
        self.performSegue(withIdentifier: "toDetailVC", sender: self.cell)
    }
}

extension RootVC: TRMosaicLayoutDelegate
{
    
    func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 150
    }
}


// WORK ON THIS EXTENSTION LATER
extension Girl
{
    enum Status
    {
        case girlIsLoggedIn, girlIsLoggedOut, girlIsPostingIso
    }
    
}
