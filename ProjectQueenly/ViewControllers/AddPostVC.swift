//
//  AddPostVC.swift
//  
//
//  Created by Irwin Gonzales on 10/8/17.
//

import UIKit
import CoreData
import Firebase

class AddPostVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTxtField: UITextField!
    @IBOutlet var sizeTxtField: UITextField!
    @IBOutlet var priceTxtField: UITextField!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var addMeasurementsBtn: UIButton!
    @IBOutlet var shilouetteTxtField: UITextField!
    @IBOutlet var colorTxtField: UITextField!
    var waistTxtField = UITextField()
    var hipTxtField = UITextField()
    var bustTxtField = UITextField()
    
    
    var designer = String()
    var size = Int()
    var price = Int()
    var shilouette = String()
    var color = String()
    var waist = Int()
    var bust = Int()
    var hip = Int()
    var image = UIImage()
    
    var addToWardrobe = Bool()
    
    var key = DataService.instance.REF_DRESS.childByAutoId().key
    
    var imagePickerController = UIImagePickerController()
    var storageRef = Firestore.firestore().collection("Dress")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        
        self.addDelegates()
        // Do any additional setup after loading the view.
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerSelectedImageView)))
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "dressicon")
        
        NotificationCenter.default.addObserver(self, selector: #selector(setWardrobeParams), name: FROM_PROFILE_VC, object: nil)
    }
    
    @objc func setWardrobeParams()
    {
        self.addToWardrobe = true
//        NotificationCenter.default.post(name: FROM_PROFILE_VC, object: nil)
    }
    
    func setObjects() -> [String : Any]?
    {
        if self.addToWardrobe == true
        {
            self.color = self.colorTxtField.text!
            self.shilouette = self.shilouetteTxtField.text!
            self.designer = self.titleTxtField.text!
            self.size = ((self.sizeTxtField.text as NSString?)?.integerValue)!
            self.bust = ((self.bustTxtField.text as NSString?)?.integerValue)!
            self.waist = ((self.waistTxtField.text as NSString?)?.integerValue)!
            self.hip = ((self.hipTxtField.text as NSString?)?.integerValue)!
            self.price = ((self.priceTxtField.text as NSString?)?.integerValue)!
            
            let wardrobeData = ["poster": Auth.auth().currentUser?.uid, "key": self.key, "designer":self.designer, "size":self.size, "color":self.color, "shilouette":self.shilouette, "waist":self.waist, "bust":self.bust, "hip":self.hip, "price": self.price, "isWardrobe": true, "image":self.imageView.image] as [String : Any]
            
            debugPrint(wardrobeData)
            return wardrobeData
        }
        else
        {
            self.color = self.colorTxtField.text!
            self.shilouette = self.shilouetteTxtField.text!
            self.designer = self.titleTxtField.text!
            self.size = ((self.sizeTxtField.text as NSString?)?.integerValue)!
            self.bust = ((self.bustTxtField.text as NSString?)?.integerValue)!
            self.waist = ((self.waistTxtField.text as NSString?)?.integerValue)!
            self.hip = ((self.hipTxtField.text as NSString?)?.integerValue)!
            self.price = ((self.priceTxtField.text as NSString?)?.integerValue)!
            
            let isoData = ["poster": Auth.auth().currentUser?.uid, "key": self.key, "designer":self.designer, "size":self.size, "color":self.color, "shilouette":self.shilouette, "waist":self.waist, "bust":self.bust, "hip":self.hip, "price": self.price, "isWardrobe": false, "image":self.imageView.image] as [String : Any]
            
            debugPrint(isoData)
            return isoData
        }
//        return nil
    }
    
    func addDelegates()
    {
        self.imagePickerController.delegate = self
        self.titleTxtField.delegate = self
        self.sizeTxtField.delegate = self
        self.priceTxtField.delegate = self
    }
    
    // UI Buttons
    func presentWarningAlertController(error:String)
    {
        let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addMeasurementsOnBtnPressed()
    {
        let alert = UIAlertController(title: "Add Measurements", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            self.waistTxtField = textField
            textField.placeholder = "Waist"
        }
        
        alert.addTextField { (textField) in
            self.hipTxtField = textField
            textField.placeholder = "Hip"
        }
        
        alert.addTextField { (textField) in
            self.bustTxtField = textField
            textField.placeholder = "Bust"
        }
        
        let save = UIAlertAction(title: "Set", style: .default) { (alert) in
//            self.setObjects()
            if self.imageView.image == nil || self.imageView.image == UIImage(named: "dressicon")
            {
                self.presentWarningAlertController(error: "Missing an Image!!")
            }
            else
            {
                print("Things are good here")
                self.performSegue(withIdentifier: "toConfirmVC", sender: self)
            }
        }
        alert.addAction(save)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func cancelBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMeasurementsOnBtnPressed(_ sender: Any)
    {
        self.addMeasurementsOnBtnPressed()
    }
    
    @IBAction func submitBtnPressed(_ sender: Any)
    {
//        self.setObjects()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toConfirmVC"
        {
            var nextVC = segue.destination as? PostConfirmVC
            nextVC?.key = self.key
            nextVC?.data = self.setObjects()!
            debugPrint(nextVC?.data)

        }
    }
    
}

