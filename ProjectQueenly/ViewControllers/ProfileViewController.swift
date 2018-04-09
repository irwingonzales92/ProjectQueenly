//
//  ProfileViewController.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/9/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var heightlabel: UILabel!
    @IBOutlet weak var shilouetteLabel: UILabel!
    @IBOutlet weak var dressCollectionView: UICollectionView!
    
    var poster = String()
    var documentId = String()


    
    var user = [String: Any?]()
    var dress = [String: Any?]()
    var dressArray = [[String: Any?]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dressCollectionView.delegate = self
        self.dressCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dressQuery()
    {

        
                storageRef.getDocuments() { (querySnapshot, err) in
                    if let err = err
                    {
                        print("Error getting documents: \(err)")
                    }
                    else
                    {
                        for document in querySnapshot!.documents
                        {
                            //                    print("\(document.documentID) => \(document.data())")
                            let documentData = document.data()
        
                           self.poster = documentData["poster"] as! String
                           self.documentId = documentData["id"] as! String
        
                            if Auth.auth().currentUser?.uid == self.poster
                            {
                                self.dressArray.append(documentData)
//                                print(dressArray)
//                                print(poster)
//                                print(documentId)
                                print("No Error, Dresses are in the Array!")
                            }
                        }
                    }
                }
    }
    
    func transferDataStringToImage()
    {
        let encodedData = self.user["image"]
        let decodedimage = UIImage(data: encodedData! as! Data)
        self.userImageView.image = decodedimage
    }
    
    func pullSavedDress()
    {
        storageRef.document((Auth.auth().currentUser?.uid)!).getDocument { (snapshot, err) in

                let user = snapshot?.data()
                
            
            self.usernameLabel.text = Auth.auth().currentUser?.displayName
            self.colorLabel.text = user?["favorite color"] as! String
            self.sizeLabel.text = user!["size"] as! String
            self.heightlabel.text = user!["height"] as! String
            self.shilouetteLabel.text = user!["shilouette"] as! String
            
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dressArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WardrobeCVC
        
        self.dress = dressArray[indexPath.row]
        cell.designerLabel.text = self.dress["designer"] as? String
        cell.backgroundColor = UIColor.red
        
        let imagesID = self.dress["image"] as? Data
        let decodedimage = UIImage(data: imagesID!)
        cell.imageView.image = decodedimage
        
        
        
        return cell
    }

    @IBAction func dismissBtnPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}


