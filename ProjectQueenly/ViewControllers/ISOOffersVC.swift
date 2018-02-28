//
//  ISOOffersVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 1/16/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase

class ISOOffersVC: UIViewController
{
    @IBOutlet var tableView: UITableView!
    
    
    var cell = GownTVC()
    var dressArray = [[String:Any]]()
    var dress = [String:Any]()
    
    var designer = String()
    var size = Int()
    var price = Int()
    var shilouette = String()
    var color = String()
    var waist = Int()
    var bust = Int()
    var hip = Int()
    var image = UIImage()
    var key = String()
    var poster = String()
    var wardrobe = Bool()
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.initalizeDelegates()
        self.pullUserProfileDress()

        // Do any additional setup after loading the view.
    }
    
    func openDictionary(dict: [String: Any])
    {
        self.bust = dict["bust"] as! Int
        self.hip = dict["hip"] as! Int
        self.cell.sizeLbl.text = dict["size"] as! String
        self.price = dict["price"] as! Int
        self.color = dict["color"] as! String
        self.shilouette = dict["shilouette"] as! String
        self.designer = dict["designer"] as! String
        self.color = dict["color"] as! String
        self.wardrobe = dict["isWardrobe"] as! Bool
        self.image = dict["image"] as! UIImage
    }
    
    func initalizeDelegates()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
//    func setStuff()
//    {
//        self.designerLabel.text = self.designer
//        self.shilouetteLabel.text = self.shilouette
//        self.colorLabel.text = self.color
//        self.imageView.image = self.image
//        self.poster = (Auth.auth().currentUser?.uid)!
//
//        let sizeString = String(self.size)
//        self.sizeLabel.text = sizeString
//
//        let priceString = String(self.price)
//        self.priceLabel.text = priceString
//
//        let waistString = String(self.waist)
//        self.waistLabel.text = waistString
//
//        let hipString = String(self.hip)
//        self.hipLabel.text = hipString
//
//        let bustString = String(self.bust)
//        self.bustLabel.text = bustString
//
//    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "fromOfferToDetailSegue"
        {
            var nextVC = segue.destination as? PostDetailVC
            nextVC?.recievedGown = self.dress
        }
    }
 
    
    func pullUserProfileDress()
    {
        var poster = String()
        var documentID = String()
        
        storageRef.getDocuments() { (querySnapshot, err) in
            if let err = err
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                for document in querySnapshot!.documents
                {
                    let documentData = document.data()
                    //                        print(documentData)
                    
                    poster = documentData["poster"] as! String
                    //                        print(poster)
                    
                    if Auth.auth().currentUser?.uid == poster
                    {
                        self.dressArray.append(documentData)
                        print("No Error, Dresses are in the Array!")
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    @IBAction func cancelBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewOfferBtnPressed(_ sender: Any)
    {
//        self.gown = gowns[indexPath.row]
        self.performSegue(withIdentifier: "fromOfferToDetailSegue", sender: self.cell)
        
        NotificationCenter.default.post(name: FROM_ISOOFFER_VC, object: nil)
    }
}

extension ISOOffersVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GownTVC
        
        self.dress = self.dressArray[indexPath.row]
        self.cell.designerLbl.text = self.dress["designer"] as? String
        self.cell.colorLbl.text = self.dress["color"] as? String
        
        let imagesID = dress["image"] as? Data
        let decodedimage = UIImage(data: imagesID!)
        self.cell.gownImageView.image = decodedimage
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
