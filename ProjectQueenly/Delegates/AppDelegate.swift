//
//  AppDelegate.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 9/28/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import Stripe
import Alamofire
import FBSDKCoreKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate var containerVC = ContainerVC()
    fileprivate var loginVC = LoginVC()
    fileprivate var welcomeVC = WelcomeVC()
    fileprivate var onboardingOne = OnboardingOneVC()
    
//    let appDelegate = AppDelegate.getAppDelegate()


    var window: UIWindow?
    
    var MenuContainerVC: ContainerVC {
        return containerVC
    }
    
    override init()
    {
        super.init()
        FirebaseApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
//        var keys: NSDictionary?
//
//        if let path = Bundle.main.path(forResource: "SecretKey", ofType: "plist") {
//            keys = NSDictionary(contentsOfFile: path)
//        }
//
//        if let dict = keys
//        {
//            let stripeKey = dict["stripeKey"] as? String
//            STPPaymentConfiguration.shared().publishableKey = stripeKey!
//        }
        
        STPPaymentConfiguration.shared().publishableKey = "test_dJnv13skfoa6Gs"
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        let defaultStore = Firestore.firestore()
        
        var storageRef = Firestore.firestore().collection("Dress")
        var userRef = Firestore.firestore().collection("Users")
        
        
        
        // Window and container elements
        containerVC = ContainerVC()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        var vc = UIViewController()
//        var vc2 = UIViewController()
        
//        window?.rootViewController = containerVC
//        window?.makeKeyAndVisible()
        
        
        
        
        
        
        if Auth.auth().currentUser == nil
        {
            vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            print(Auth.auth().currentUser)
            AppFunctions.setMainViewController(vc: vc)
            

        }
        else
        {
            if Auth.auth().currentUser?.uid == nil
            {
                // Show onboarding
                print("Has not onboarded")
                print("This User Has Not Onboarded:\(Auth.auth().currentUser)")

                vc = storyboard.instantiateViewController(withIdentifier: "OnboardingOneVC")
                AppFunctions.setMainViewController(vc: vc)
            }
            else
            {
                // Show main window
                print("User is logged in")
                print("This User Has Onboarded:\(Auth.auth().currentUser)")

                AppFunctions.setMainViewController(vc: containerVC)
            }
        }

        
    
        
        
        
        
//
//        if (UserDefaults.standard.value(forKey: "name") as? String) == nil
//        {
//            // Show onboarding
//            print("User is NOT logged in")
//            print(UserDefaults.standard.value(forKey: "name") as! String)
//            vc = storyboard.instantiateViewController(withIdentifier: "OnboardingOneVC")
////            self.window.present(vc!, animated: true, completion: nil)
//            window?.rootViewController = vc
//            window?.makeKeyAndVisible()
//        }
//        else
//        {
//            // Show main window
//            print("User is logged in")
//            print(UserDefaults.standard.value(forKey: "name") as! String)
//            window?.rootViewController = containerVC
//            vc = storyboard.instantiateInitialViewController()!
//            window?.makeKeyAndVisible()
//        }
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//
//        var layout = UICollectionViewLayout()
//        window?.rootViewController = UINavigationController(rootViewController: RootVC(coder: layout))
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ProjectQueenly")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /// STRIPE FEATURES ///
    
    // This method is where you handle URL opens if you are using a native scheme URLs (eg "yourexampleapp://")
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let stripeHandled = Stripe.handleURLCallback(with: url)

        let handled  = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        if (stripeHandled) {
            return true
        }
        else {
            
        }
        
        return handled
    }
    
    // This method is where you handle URL opens if you are using univeral link URLs (eg "https://example.com/stripe_ios_callback")
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let stripeHandled = Stripe.handleURLCallback(with: url)
                
                if (stripeHandled) {
                    return true
                }
                else {
                    // This was not a stripe url, do whatever url handling your app
                    // normally does, if any.
                }
            }
            
        }
        return false
    }

}

