//
//  RootViewController.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 9/28/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit

class RootVC: UIViewController
{
    
    @IBOutlet var tableView: UITableView!
    var itemArray = [Post]()
    var cell = PostTableViewCell()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpDelegates()
//        view.backgroundColor = UIColor.red
    }

    
// Helper Methods
    
    func setUpDelegates()
    {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
// Table View

    @IBAction func contactBtnPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func postButtonPressed(_ sender: Any)
    {

    }
}

extension RootVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        self.cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
//        let post = itemArray[indexPath.row]
//        cell.titleLabel.text = post.title
//        cell.ownerLabel.text = post.name
//        cell.priceLabel.text = "/(post.price)"
//        cell.sizeLabel.text = "/(post.size)"
        
        cell.titleLabel.text = "Jovani Dress"
        cell.ownerLabel.text = "Trisha B"
        cell.priceLabel.text = "1400"
        cell.sizeLabel.text = "0"
        cell.postImageView.image = UIImage(named: "jovani42919")
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 374
    }
    
}


