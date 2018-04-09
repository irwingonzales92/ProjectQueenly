//
//  LeftPanelVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase


class LeftPanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func feedBtnPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let offerVC = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as? ProfileViewController
        present(offerVC!, animated: true, completion: nil)
    }
    
    @IBAction func msgBtnPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let offerVC = storyboard.instantiateViewController(withIdentifier: "OffersVC") as? ISOOffersVC
        present(offerVC!, animated: true, completion: nil)
    }
    
    @IBAction func orderBtnPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let faqVC = storyboard.instantiateViewController(withIdentifier: "FAQVC") as? FAQVC
        present(faqVC!, animated: true, completion: nil)
    }
    
    @IBAction func profileBtnPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        present(profileVC!, animated: true, completion: nil)
    }
    @IBAction func authBtnPressed(_ sender: Any)
    {
        if Auth.auth().currentUser == nil
        {
//            delegate?.toggleLoginVC()
//            appDelegate.MenuContainerVC.toggleLoginVC()
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            let profileVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
//            present(profileVC!, animated: true, completion: nil)
        }
        else
        {
            let alertVC = UIAlertController(title: "Would you like to log out?", message: "", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
                print("Capture action Cancel")
            }))
            
            alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
                do
                {
                    try Auth.auth().signOut()
                    print("User Successfully Signed Out")
                    self.viewWillAppear(true) //RELOADS HOME VIEW CONTROLLER!!!
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let offerVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                    self.present(offerVC!, animated: true, completion: nil)
                }
                catch (let error)
                {
                    print(error)
                }
                
            }))
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
    }
}
