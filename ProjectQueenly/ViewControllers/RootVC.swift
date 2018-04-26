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
import AZEmptyState
import RxSwift
import RxCocoa

class RootVC: UIViewController, AddPostVCDelegate
{
    
    func didSetPostType() -> State {
        return postType.value
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var postBtn: RoundedShadowButton!
    
    
    // Object Container Types
    var gownArray = [[String: Any?]]()
    var gownObj = [String: Any?]()
    var selectedGown: UIImage?
    
    let postType = Variable<State>(.ISO)
    var selectedType: Observable<State> {
        return postType.asObservable()
    }
    
    let wardrobeType: PostType = .ISO
    
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
    
    var disposeBag = DisposeBag()
    
    var emptyStateView:AZEmptyStateView?
    
    // App State    
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


    // MARK: - Actions
    
    @IBAction func postButtonPressed(_ sender: Any)
    {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let postVC = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as? AddPostVC
//
//        postType.value = .ISO
//        print("Post Type Value: \(postType.value)")
//
//        postVC?.delegate = self
//
//
//
////        print(FROM_ROOT_VC)
//        present(postVC!, animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let postVC = storyboard.instantiateViewController(withIdentifier: "AddISOVC") as? AddISOVC
        
        postType.value = .ISO
        print("Post Type Value: \(postType.value)")
        
        postVC?.delegate = self
        
        
        
        //        print(FROM_ROOT_VC)
        present(postVC!, animated: true, completion: nil)

    }
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        appDelegate.MenuContainerVC.toggleLeftPanel()        
    }
    
    func setPostType(_ type: State) -> ()
    {
        
    }
    
}
