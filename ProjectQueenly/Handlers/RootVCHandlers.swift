//
//  RootVCHandlers.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/6/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import CoreData
import RevealingSplashView
import Firebase
import TRMosaicLayout
import AZEmptyState
import RxSwift
import RxCocoa

extension RootVC
{
    enum UserState
    {
        case userIsLoggedIn, userIsPostingIso
    }
    
    enum DressCount
    {
        case empty
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
            //            debugPrint(self.girl?.email)
            self.pullSavedDress()
            //            print(gowns.count)
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
        
        if self.gownArray.count == 0
        {
            //init var
            
            //customize
            
            self.emptyStateView = AZEmptyStateView(image: UIImage(named: "sad")!, message: "No Dresses Up Yet!")
            self.emptyStateView?.buttonText = "Search For One!"
            self.emptyStateView?.buttonTint = .purple
            self.emptyStateView?.addTarget(self, action: #selector(postButtonPressed(_:)), for: .touchUpInside)
            
            self.postBtn.isHidden = true
            
            //add subview
            view.addSubview(emptyStateView!)
            
            //add autolayout
            self.emptyStateView?.translatesAutoresizingMaskIntoConstraints = false
            self.emptyStateView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.emptyStateView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.emptyStateView?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
            self.emptyStateView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55).isActive = true
        }
        else
        {
            //            debugPrint(self.gowns.count)
            self.collectionView.reloadData()
            self.emptyStateView?.removeFromSuperview()
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
        
        if self.gownArray.count != self.gownArray.count
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
                if querySnapshot != nil
                {
                    for document in querySnapshot!.documents
                    {
                        let documentData = document.data()
                        
                        let ref = self.storageRef.document()
                        //                        ref.setModel(self.gownObj)
                        self.gownObj = documentData
                        self.gownArray.append(self.gownObj)
                        self.collectionView.reloadData()
                    }
                }
                else
                {
                    print("No Wardrobes!")
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "didCheckPostSegue"
        {
            let nextVC = segue.destination as? GownDetailViewController
            //            nextVC?.recievedGown = self.gown
            nextVC?.gownData = self.gownObj
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

    
}

extension RootVC: UICollectionViewDataSource, UICollectionViewDelegate
{
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return 1
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.gownArray.count)
        return self.gownArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostCVC
        
        
        self.gownObj = gownArray[indexPath.row]
        self.cell.designerLabel.text = self.gown["designer"] as? String
        print(self.cell.designerLabel.text)
        self.cell.backgroundColor = UIColor.red
        
        let imagesID = self.gownObj["image"] as? Data
        let decodedimage = UIImage(data: imagesID!)
        self.cell.imageView.image = decodedimage
        
        
        return self.cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 100);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.gownObj = gownArray[indexPath.row]
        self.performSegue(withIdentifier: "didCheckPostSegue", sender: self.cell)
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


