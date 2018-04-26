//
//  AddISOVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/19/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

enum PostType
{
    case ISO, Wardrobe
}

protocol AddISODelegate
{
    func didSetPostType() -> PostType
}

class AddISOVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var postType: PostType = .ISO
    var delegate: AddISODelegate?
    
    // Set Object Dictionary
    
    var postTitle = String()
    var postColor = String()
    var postDescritption = String()
    var postImage = UIImage()
    var postPriceRange1 = Int()
    var postPriceRange2 = Int()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setPostType()

        // Do any additional setup after loading the view.
    }
    
    func setPostType()
    {
        self.postType = (delegate?.didSetPostType())!
        
        switch self.postType
        {
            case .ISO:
                print("dress is an iso post")
    
            case .Wardrobe:
                print("dress is adding to wardrobe")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
 

}

extension AddISOVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageInputCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleInputCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "priceCell") as! PriceInputCell
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "colorCell") as! ColorInputCell
        let cell5 = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! DescriptionInputCell
        let cell6 = tableView.dequeueReusableCell(withIdentifier: "measurementCell") as! GownMeasurementBtnTVCell
        let cell7 = tableView.dequeueReusableCell(withIdentifier: "actionCell") as! NextBtnTVCell
        
        switch indexPath.row
        {
        case 0:
            cell1.gownImageView?.image = self.postImage
            return cell1
        case 1:

            cell2.titleTextField.text = self.postTitle
            return cell2
        case 2:

            // amitiitm2009@gmail.com
            cell3.priceRangeTextField1.text = String(self.postPriceRange1)
            return cell3
        case 3:
            cell4.colorTextField.text = self.postColor
            return cell4
        case 4:
            cell5.gownDescriptionTextView.text = self.postDescritption
            return cell5
        case 5:
            return cell6
        case 6:
            cell7.delegate = self
            return cell7
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row
        {
        case 0:
            return 300
        case 1:
            return 50
        case 2:
            return 50
        case 3:
            return 45
        case 4:
            return 100
        case 5:
            return 50
        case 6:
            return 60
            
        default:
            return 45
        }
    }
}

extension AddISOVC: NextBtnTVCellDelegate
{
    func didSetGownParams() {
        <#code#>
    }
    
    func isAcceptingOffer() {
        <#code#>
    }
    
    func isMakingOffer() {
        <#code#>
    }
    
    func isViewingPost() {
        <#code#>
    }
    
    
}
