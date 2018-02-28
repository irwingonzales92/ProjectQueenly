//
//  AddToWardrobeVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/15/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import PMAlertController
import CoreData
import Firebase

class AddToWardrobeVC: UIViewController {

    @IBOutlet var wardrobeImageView: UIImageView!
    
    @IBOutlet var designerTextField: UITextField!
    
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var originalPriceTextField: UITextField!
    @IBOutlet var silhouettePickerView: UIPickerView!
    @IBOutlet var conditionPickerView: UIPickerView!
    @IBOutlet var dressSizePickerView: UIPickerView!
    
    @IBOutlet var forSaleSwitch: UISwitch!
    
    
    var imagePickerController = UIImagePickerController()
    var silhousetteArray: [String] = []
    var conditionArray: [String] = []
    var dressSizeArray: [String] = []
    
    var key = DataService.instance.REF_DRESS.childByAutoId().key
    
    var wardrobeImage: UIImage?
    var wardrobePrice: Int?
    var wardrobeCondition: String?
    var wardrobeSize: String?
    var wardrobeSilhouette: String?
    var wardrobeOriginalPrice: Int?
    var wardrobeIsIso: Bool?
    var wardrobeIsForSale: Bool?
    var wardrobeDesigner: String?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.setUpMethods()
//        self.setInitializers()
        
        

    }

    @IBAction func addPhotoBtnPressed(_ sender: Any)
    {
        
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

    func setUpMethods()
    {
        silhouettePickerView.dataSource = self
        conditionPickerView.dataSource = self
        dressSizePickerView.dataSource = self
        
        self.imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        silhouettePickerView.delegate = self
        conditionPickerView.delegate = self
        dressSizePickerView.delegate = self
        
        silhouettePickerView.tag = 1
        conditionPickerView.tag = 2
        dressSizePickerView.tag = 3
        
        self.silhousetteArray = ["Skinny", "Medium", "Large"]
        self.conditionArray = ["New", "Like New", "Used", "Super Used", "Bad"]
        self.dressSizeArray = ["0", "2", "4", "6", "8", "12", "16", "18"]
    }
    
    @IBAction func backBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToWardrobeBtnPressed(_ sender: Any)
    {
        let alertVC = PMAlertController(title: "Wardrobe Added!!", description: "Dress has been added to your wardrobe!", image: UIImage(named: ""), style: .alert)
        
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            print("Capture action OK")
            
            self.wardrobeDesigner = self.designerTextField.text
            self.wardrobePrice = ((self.priceTextField.text as NSString?)?.integerValue)!
//            self.wardrobeCondition = self.conditionArra
            
            
//            self.save(designer: self.wardrobeDesigner!, condition: self.wardrobeCondition!, forSale: self.wardrobeIsForSale!, isIso: self.wardrobeIsIso!, originalPrice: self.wardrobeOriginalPrice!, price: self.wardrobePrice!, silhouette: self.wardrobeSilhouette!)
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func setObjects() -> [String : Any]
    {
        
//        var wardrobeImage: UIImage? *
//        var wardrobePrice: Int? **
//        var wardrobeCondition: String? *
//        var wardrobeSize: String? *
//        var wardrobeSilhouette: String?
//        var wardrobeOriginalPrice: Int?
//        var wardrobeIsIso: Bool?
//        var wardrobeIsForSale: Bool?
//        var wardrobeDesigner: String?
        
        
        
        self.wardrobePrice = (self.priceTextField.text as NSString?)?.integerValue
        
        let data = ["poster": Auth.auth().currentUser?.uid, "id": self.key, "designer":self.wardrobeDesigner, "size":self.wardrobeSize, "shilouette":self.wardrobeSilhouette,  "price": self.wardrobePrice, "image":self.wardrobeImage] as [String : Any]
        
        
        return data
    }
    
}

extension AddToWardrobeVC: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag
        {
        case 1:
            return silhousetteArray.count
        case 2:
            return conditionArray.count
        case 3:
            return dressSizeArray.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        switch pickerView.tag
        {
        case 1:
            self.wardrobeSilhouette = silhousetteArray[row]
            return silhousetteArray[row]
        case 2:
            self.wardrobeCondition = conditionArray[row]
            return conditionArray[row]
        case 3:
            self.wardrobeSize = dressSizeArray[row]
            return dressSizeArray[row]
        default:
            return nil
        }
    }

}

extension AddToWardrobeVC: UITextFieldDelegate
{
    
}

// ****** BUG ******* //

// Photo not appearing in imageview

extension AddToWardrobeVC: UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.wardrobeImageView.image = image
        self.wardrobeImage = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}
