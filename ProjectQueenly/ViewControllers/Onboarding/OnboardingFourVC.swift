//
//  OnboardingFourVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 2/7/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase


class OnboardingFourVC: UIViewController {

    @IBOutlet var designerTxtField: RoundedCornerTextField!
    @IBOutlet var sizeTxtFld: RoundedCornerTextField!
    @IBOutlet var favoriteColorTxtField: RoundedCornerTextField!
    @IBOutlet var shilouetteTxtField: RoundedCornerTextField!
    @IBOutlet var waistTxtField: RoundedCornerTextField!
    @IBOutlet var bustTxtField: RoundedCornerTextField!
    @IBOutlet var hipTxtField: RoundedCornerTextField!
    
    var designer = String()
    var size = Int()
    var shilouette = String()
    var color = String()
    var waist = Int()
    var bust = Int()
    var hip = Int()
    var image = UIImage()
    
    var userInfo = [String:Any?]()
    
    var userRef = Firestore.firestore().collection("Users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userInfo)

        // Do any additional setup after loading the view.
    }
    
    
    func setStuff() -> [String: Any?]
    {
        self.size = ((self.sizeTxtFld.text! as NSString).integerValue)
        self.bust = ((self.bustTxtField.text! as NSString).integerValue)
        self.waist = ((self.waistTxtField.text! as NSString).integerValue)
        self.hip = ((self.hipTxtField.text! as NSString).integerValue)
        
        self.shilouette = self.shilouetteTxtField.text!
        self.designer = self.designerTxtField.text!
        self.color = self.favoriteColorTxtField.text!
        
        let array = ["size": self.size, "bust": self.bust, "waist": self.waist, "hip":self.hip, "shilouette":self.shilouette, "designer":self.designer, "color":self.color] as [String:Any?]
        
        return array
    }
    
    func setUserProfileUpdate()
    {
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            
//            changeRequest.displayName = self.userDisplayName
            changeRequest.displayName = self.userInfo["displayName"] as! String
        }
    }
    
    func addParamsToUser()
    {
        var addedDict = self.setStuff()
        addedDict.merge(dict: self.userInfo)
        debugPrint(addedDict)
        
//        DataService.instance.createFirestoreUser(uid: (Auth.auth().currentUser?.uid)!, userData:addedDict ?? [String:Any?])
        
        self.setUserProfileUpdate()
        self.userRef.addDocument(data: addedDict) { (err) in
            if err == nil
            {
                debugPrint("User info successfully saved")
            }
            else
            {
                debugPrint(err?.localizedDescription ?? String())
            }
        }
    }

    
    @IBAction func completeProfileCreationBtn(_ sender: Any)
    {
        self.addParamsToUser()
        performSegue(withIdentifier: "toOnboardingVCFiveSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        if segue.identifier == "toOnboardingVCFiveSegue"
//        {
//            var nextVC = segue.destination as? OnboardingTwoVC
////            nextVC?.recievedGown = self.gown
//        }
    }

}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
