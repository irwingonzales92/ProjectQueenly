//
//  AddPostVC.swift
//  
//
//  Created by Irwin Gonzales on 10/8/17.
//

import UIKit
import CoreData
import FirebaseFirestore
import Firebase
import SkyFloatingLabelTextField
import RSKPlaceholderTextView

enum State {
    case ISO, inSearchOf, wardrobe
}

class AddPostVC: UIViewController, UITextFieldDelegate {
    
    var state: State = .ISO
    @IBOutlet var descriptionTextView: RSKPlaceholderTextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTxtField: SkyFloatingLabelTextField!
    @IBOutlet var priceTxtField: SkyFloatingLabelTextField!
    @IBOutlet var price2TxtField: SkyFloatingLabelTextField!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var addMeasurementsBtn: RoundedShadowButton!
    var waistTxtField = UITextField()
    var hipTxtField = UITextField()
    var bustTxtField = UITextField()
    var picker: PickerType?
    var poster: PostKind?
    
    @IBOutlet var addColorBtn: RoundedShadowButton!
    
    // Popup UI Elements
    @IBOutlet var conditionalPickerView: UIView!
    @IBOutlet var setDressConditionsBtn: UIView!
    @IBOutlet var cancelConditionBtn: UIButton!
    @IBOutlet var popUpCenterConstraint: NSLayoutConstraint!
    @IBOutlet var blurBackgroundConstraint: NSLayoutConstraint!
    @IBOutlet var conditionPopUpView: UIView!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var blurView: UIVisualEffectView!
    
    let conditionsArray = ["Brand New", "Very Good", "Good", "Fair", "Poor"]
    let colorsArray = ["Black", "White", "Red", "Blue", "Yellow", "Green", "Purple", "Orange", "Gold", "Silver", "Pink", "Beige"]
    
    
    var girl = Girl()
    
    var dressTitle = String()
    var size = Int()
    var priceRange1 = Int()
    var priceRange2 = Int()
    var shilouette = String()
    var color = String()
    var waist = Int()
    var bust = Int()
    var hip = Int()
    var image = UIImage()
    var postType = String()
    
    var gown: Gown?
    
    var aSender: RoundedShadowButton?

    var gownCondition: String?
    var gownDescription = String()
    
    var addToWardrobe = Bool()
    var isWardrobe = Bool()
    
    var key = DataService.instance.REF_DRESS.childByAutoId().key
    
    var imagePickerController = UIImagePickerController()
    var storageRef = Firestore.firestore().collection("Dress")
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupView()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(setWardrobeParams(notificationName:)), name: FROM_ROOT_VC, object: nil)
//        print("Notification Observed")
        
        
        //                let isFromRootVC = note.name == FROM_ROOT_VC
        //                let postFromVc = isFromRootVC ? "IsoPost" : "WardrobePost"

        
//        self.addColorBtn.tag = 0
//        self.addMeasurementsBtn.tag = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
    }
    

    @IBAction func exitConditionBtnPressed(_ sender: Any)
    {
        self.dismissConditionViewController()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addColorOnBtnPressed(_ sender: Any)
    {
        self.checkButtonTag(sender: self.addColorBtn)
    }
    
    @IBAction func addMeasurementsOnBtnPressed(_ sender: Any)
    {
        self.checkButtonTag(sender: self.addMeasurementsBtn)
    }
    @IBAction func setDressMeasurementsOnBtnPressed(_ sender: Any)
    {
        self.dismissConditionViewController()
    }
    
    @IBAction func submitBtnPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toConfirmVC", sender: nil)
    }

}


