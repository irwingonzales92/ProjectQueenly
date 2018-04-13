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
//import RxSwift
import RxSwift

enum State {
    case ISO, wardrobe
}

protocol AddPostVCDelegate
{
    func didSetPostType() -> State
}

class AddPostVC: UIViewController {

    

    
    
    var state: State = .ISO
    var disposeBag = DisposeBag()
    
    var delegate: AddPostVCDelegate?
    
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
    
    
    @IBOutlet weak var detailPopUpView: UIView!
    @IBOutlet weak var detailPopUpImage: UIImageView!
    @IBOutlet weak var detailPopUpTitle: UILabel!
    @IBOutlet weak var detailPopUpPrice: UILabel!
    @IBOutlet weak var detailPopUpColor: UILabel!
    @IBOutlet weak var detailPopUpDescription: UILabel!
    @IBOutlet weak var detailPopUpBtn: UIButton!
    
    
    // Popup UI Elements
    @IBOutlet var conditionalPickerView: UIView!
    @IBOutlet var setDressConditionsBtn: UIView!
    @IBOutlet var cancelConditionBtn: UIButton!
    @IBOutlet var popUpCenterConstraint: NSLayoutConstraint!
    @IBOutlet var blurBackgroundConstraint: NSLayoutConstraint!
    @IBOutlet var detailConstraint: NSLayoutConstraint!
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
    var imageData = Data()
    var postType = String()
    
    var authUser = Auth.auth().currentUser
    
    var gown: [String:Any?]?
    var user: [String:Any?]?
    
    var gownToBePassed = [String:Any]()
    
    var aSender: RoundedShadowButton?

    var gownCondition: String?
    var gownDescription = String()
    
    var addToWardrobe = Bool()
    var isWardrobe = Bool()
    
    var isIso = Variable<State>(.ISO)
    var isoObservable: Observable<State> {
        return isIso.asObservable()
    }
    
    
    var key = DataService.instance.REF_DRESS.childByAutoId().key
    
    var imagePickerController = UIImagePickerController()
    var storageRef = Firestore.firestore().collection("Dress")
    
    let gownType = Variable<State>(.ISO)
    var selectedType: Observable<State> {
        return gownType.asObservable()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupView()
//        self.oberverSetup()
        self.setWardrobeType()
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
        self.addConditionOnButtonPressed()

        self.checkButtonTag(sender: self.addColorBtn)
    }
    
    @IBAction func addMeasurementsOnBtnPressed(_ sender: Any)
    {
        self.addConditionOnButtonPressed()

    }
    @IBAction func setDressMeasurementsOnBtnPressed(_ sender: Any)
    {
        self.dismissConditionViewController()
    }
    
    @IBAction func submitBtnPressed(_ sender: Any)
    {
//        self.setGownParams(type: self.postType)
//        self.checkDetailsOnBtnPressed()
        performSegue(withIdentifier: "toConfirmDetailsVC", sender: nil)
    }
    
    @IBAction func detailPopupBtnPressed(_ sender: Any)
    {
        self.dismissDetailsOnBtnPressed()
    }
    
    func setWardrobeType() {
        self.state = (delegate?.didSetPostType())!
        
        switch self.state
        {
        case .ISO:
            self.addMeasurementsBtn.isHidden = true
        case .wardrobe:
            self.addMeasurementsBtn.isHidden = false
        }
        
        print(self.state)
    }

}


