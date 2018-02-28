//
//  RootViewController.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 9/28/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import CoreData
import RevealingSplashView
import Firebase
import TRMosaicLayout

class RootVC: UIViewController
{
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    
    // Object Container Types
    var gowns = [[String:Any]]()
    var gownObj = Gown()
    var selectedGown: UIImage!
    
    // DB Refrence & Delegate
    let appDelegate = AppDelegate.getAppDelegate()
    var delegate: CenterVCDelegate?
    var storageRef = Firestore.firestore().collection("Dress")
    
    // UI Elements
    var refreshControl = UIRefreshControl()
    var cell = PostCVC()
    let mosaicLayout = TRMosaicLayout()
    
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
    
//    var postDetailVc = PostDetailVC()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        /*
         
         **** POST RE-WIRE TASK LIST ****
         
         ** To Do **
         
         1. Configure Stripe
         2. Finish the offer wardrobe functions (after Stripe)
         3. Cleanup UI.
         4. Bug Sweep
         
         ---. Done! .---
         
         ** Incomplete Shit TO-DO **
                  
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name.init(rawValue: "UserLoggedIn"), object: nil)
        
        setUpDelegates()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: ISO_POST, object: nil)
        BackendStuff.instance.insertDressToOwner()
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
            debugPrint(Auth.auth().currentUser?.email as! String)
            //            gowns = self.pullSavedDress()
            
            self.pullSavedDress()
            print(gowns.count)
        }
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Crown")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
        
        self.collectionView.isScrollEnabled = true
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControlEvents.valueChanged)
        //        collectionView.addSubview(refreshControl)
        collectionView.refreshControl = self.refreshControl
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
//                    print("\(document.documentID) => \(document.data())")
                    let documentData = document.data()
                    
                    
                    self.gowns.append(documentData)
                    print(self.gowns.count)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetailVC"
        {
            var nextVC = segue.destination as? PostDetailVC
            nextVC?.recievedGown = self.gown
        }
        else
        {
            NotificationCenter.default.post(name: VIEW_DRESS_POST, object: nil)
            print("View Notification Posted")
        }
     }
 


    
    @IBAction func postButtonPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let postVC = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as? AddPostVC
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
        
        
        self.gown = gowns[indexPath.row]
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
        self.gown = gowns[indexPath.row]
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

