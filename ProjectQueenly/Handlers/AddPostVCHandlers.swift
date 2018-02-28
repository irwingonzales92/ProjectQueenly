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

extension AddPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
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
                let imageData: NSData = UIImagePNGRepresentation(image) as! NSData
                imageView.image = image
            }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"]
            {
                print(originalImage)
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                let imageData: NSData = UIImagePNGRepresentation(image) as! NSData
                imageView.image = image
            }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddPostVC: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
}

