//
//  AddPostVCHandlers.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 11/10/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum PostKind: String
{
    case isIsoPost = "isoPost"
    case isWardobePost = "wardrobePost"
}

enum PickerType
{
    case conditions, colors
}

enum DressCondition: String
{
    case unused, excellent, good, okay, wearingdown, damaged
}

enum TextFieldTags: Int
{
    case titleTag = 0, priceTag = 1, price2Tag = 2
}

extension AddPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //////////////////////
    // HELPER FUNCTIONS //
    //////////////////////
    
    func setupView()
    {
        view.bindToKeyboard()
        
        conditionPopUpView.layer.cornerRadius = 10
        conditionPopUpView.layer.masksToBounds = true
        
        self.addDelegates()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissConditionViewController)))
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerSelectedImageView)))
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "dressicon")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(setWardrobeParams(notificationName:)), name: FROM_PROFILE_VC, object: nil)
        

        
    }
    

    
    
   @objc func handlerSelectedImageView()
    {
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Choose A Photo", message: "Choose a picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"]
            {
                print(editedImage)
                print(info)
                let image = info[UIImagePickerControllerEditedImage] as! UIImage
                imageView.image = image
            }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"]
            {
                print(originalImage)
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                imageView.image = image
            }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentWarningAlertController(error:String)
    {
        let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addConditionOnButtonPressed()
    {
        
        self.popUpCenterConstraint.constant = 0
        blurBackgroundConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            
            self.blurView.alpha = 1
        }
        self.pickerView.reloadAllComponents()
    }
    
    @objc func dismissConditionViewController()
    {
        self.popUpCenterConstraint.constant = -400
        blurBackgroundConstraint.constant = -400
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.blurView.alpha = 0
        }
        
        self.pickerView.reloadAllComponents()
    }
    

    
    func setGownParams(type: String) -> Gown?
    {
        self.gownDescription = self.descriptionTextView.text!
        self.title = self.titleTxtField.text!
        self.size = ((self.titleTxtField.text as NSString?)?.integerValue)!
        self.bust = ((self.bustTxtField.text as NSString?)?.integerValue)!
        self.waist = ((self.waistTxtField.text as NSString?)?.integerValue)!
        self.hip = ((self.hipTxtField.text as NSString?)?.integerValue)!
        self.priceRange1 = ((self.priceTxtField.text as NSString?)?.integerValue)!
        self.priceRange2 = ((self.price2TxtField.text as NSString?)?.integerValue)!
        
        var gown: Gown?
        
        NotificationCenter.default.addObserver(forName: FROM_ROOT_VC, object: nil, queue: nil) { (note) in
            print(note.name)
            
            let postText = "IsoPost"
            self.postType = postText
            print(self.postType)
        }
        
        print(self.postType)
        print("Self.PostType")
        
        gown = Gown(title: self.dressTitle, size: self.girl.size, priceRange1: self.priceRange1, priceRange2: self.priceRange2, shilouette: self.girl.shilouette, color: self.color, waist: self.girl.waist, bust: self.girl.bust, hip: self.girl.hip, image: self.transformImageToDataString(image: self.imageView.image!), isbn: self.key, poster: self.girl.documentID , offers: nil, description: self.description, condition: self.gownCondition, postType: self.postType)
        
        print(gown)
        return gown
    }
    
    func addDelegates()
    {
        self.imagePickerController.delegate = self
        self.titleTxtField.delegate = self
        self.priceTxtField.delegate = self
        self.price2TxtField.delegate = self
        self.pickerView.delegate = self
        self.descriptionTextView.delegate = self
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.textViewSetup()
        
    }
    
    func textViewSetup()
    {
        self.titleTxtField.tag = TextFieldTags.titleTag.rawValue
        self.priceTxtField.tag = TextFieldTags.priceTag.rawValue
        self.price2TxtField.tag = TextFieldTags.price2Tag.rawValue
    }
    
    func transformImageToDataString(image:UIImage) -> Data
    {
        let metaData = UIImagePNGRepresentation(image)
        
        return metaData!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toConfirmVC"
        {
            var nextVC = segue.destination as? PostConfirmVC
            nextVC?.key = self.key
            //            nextVC?.data = self.setObjects()!
            self.gown = self.setGownParams(type: self.postType)
            if let gown = gown {
                let gownModel = GownItems(gownObj: gown)
                nextVC?.gownArray = gownModel.items
            }
        }
    }
    
    @objc func setWardrobeParams(notificationName: NSNotification.Name)
    {
        let isFromRootVC = notificationName == FROM_ROOT_VC
        let postFromVc = isFromRootVC ? "IsoPost" : "WardrobePost"
        
        self.postType = postFromVc
//        if FROM_ROOT_VC == notificationName
//        {
//            self.poster = .isIsoPost
//            print("Posting Iso Dress")
//        }
//        else
//        {
//            self.poster = .isWardobePost
//            print("Posting Wardrobe Dress")
//        }
    }
    
    
    func checkButtonTag(sender: RoundedShadowButton) -> RoundedShadowButton
    {
        switch sender.tag
        {
        case 0:
            self.picker = .colors
            self.addConditionOnButtonPressed()
            self.aSender = sender
            print(self.aSender?.tag)
            print(self.picker)
            return self.aSender!
            
        case 1:
            self.picker = .conditions
            self.addConditionOnButtonPressed()
            self.aSender = sender
            print(self.aSender?.tag)
            print(self.picker)
            return self.aSender!
            
        default:
            print("Something broke")
            self.addConditionOnButtonPressed()
            print(sender.tag)
            return self.aSender!
        }
    }
}
    ////////////////
    // EXTENSIONS //
    ////////////////

extension AddPostVC: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        self.descriptionTextView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        self.descriptionTextView.resignFirstResponder()
    }
}

extension AddPostVC: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        switch self.picker
        {
        case .conditions?:
            return conditionsArray[row]
            
        default:
            return colorsArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        switch self.picker
        {
        case .conditions?:
            return conditionsArray.count
            
        default:
            return colorsArray.count
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
//                self.gownCondition = AddPostVC.DressCondition(rawValue: conditionsArray[row])
        
//        self.gownCondition = AddPostVC.DressCondition(rawValue: self.conditionsArray[row] as String)
//        self.checkButtonTag(sender: self.aSender!)

        
       switch self.picker
        {
       case .conditions?:
            switch row {
            case row:
                self.gownCondition = self.conditionsArray[row]

                
            default:
                self.gownCondition = self.conditionsArray[row]
            }
       case .colors?:
            switch row {
            case row:
                self.color = self.colorsArray[row]
                
            default:
                self.color = self.colorsArray[row]
            }

       case .none:
        break
        }

    }
    
    
}



