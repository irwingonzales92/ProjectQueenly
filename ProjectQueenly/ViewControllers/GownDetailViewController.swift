//
//  GownDetailViewController.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/12/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

enum DetailType
{
    case iso, wardrobe
}

class GownDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gownData = [String:Any]()
    
    var postType = DetailType.iso
    
    var imageData = Data()
    var image = UIImage()
    var price = Int()
    var price2 = Int()
    var gownTitle = String()
    var poster = String()
    var color = String()
    var gownDescription = String()
    var key = String()
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(gownData)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func unloadDictionary(dict: [String:Any])
    {
        self.imageData = dict["image"] as! Data
        let image = UIImage(data: self.imageData)
        
        self.price = dict["priceRangeOne"] as! Int
        self.gownTitle = dict["title"] as! String
        self.poster = dict["poster"] as! String
        self.color = dict["color"] as! String
        self.gownDescription = dict["description"] as! String
    }
    
    @IBAction func didExitViewOnBtnPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didSaveGownOnBtnPressed(_ sender: Any)
    {
        storageRef.document().setData(self.gownData) { (err) in
            if err == nil
            {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func transformImageToDataString(image:UIImage) -> Data
    {
        let metaData = UIImagePNGRepresentation(image)
        
        return metaData!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! GownImageTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! GownTitleTVCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "priceCell") as! GownPriceAndPosterTvCell
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "colorCell") as! ColorTVCell
        let cell5 = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! GownDescriptionTVCell
        let cell6 = tableView.dequeueReusableCell(withIdentifier: "measurementCell") as! GownMeasurementBtnTVCell
        let cell7 = tableView.dequeueReusableCell(withIdentifier: "actionCell") as! NextBtnTVCell
        
        switch indexPath.row
        {
        case 0:
            cell1.gownImageView?.image = self.image
//            cell1.gownImageView?.image = self.gownData[]
            return cell1
        case 1:
//            cell2.titleLabel?.text = self.gownTitle
            cell2.titleLabel?.text = self.gownData["title"] as! String
            return cell2
        case 2:
            cell3.priceLabel.text = String(self.price)
            cell3.posterLabel.text = String(self.price2)
//            cell3.priceLabel.text = self.gownData["priceOne"] as! String
//            cell3.posterLabel.text = self.gownData["priceTwo"] as! String
            return cell3
        case 3:
//            cell4.colorLabel.text = self.color
            cell4.colorLabel.text = self.gownData["color"] as! String
            return cell4
        case 4:
            cell5.decsriptionTextView.text = self.gownDescription
            return cell5
        case 5:
            return cell6
        case 6:
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
