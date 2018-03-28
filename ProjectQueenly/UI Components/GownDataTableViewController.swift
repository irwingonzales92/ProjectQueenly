//
//  GownDataTableViewController.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/23/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit
import Firebase
//
//enum GownViewModelItemType {
//    case title, displayName, price, color, description, measurements
//}
//
//protocol GownDataViewModelItem {
//    var type: GownViewModelItemType {get}
//    var rowCount: Int {get}
//    var sectionTitle: String {get}
//}

class GownDataTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView?.dataSource = GownViewModel

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension GownDataViewModelItem
//{
//    var rowCount: Int
//    {
//        return 1
//    }
//}
//
//class GownDataModelNameItem: GownDataViewModelItem
//{
//    
//    var type: GownViewModelItemType
//    {
//        return .title
//    }
//    
//    var sectionTitle: String
//    {
//        return "Main Info"
//    }
//    
//    var postTitle: String
//    
//    init(title: String)
//    {
//        self.postTitle = title
//    }
//}
//
//class GownDataDisplayItem: GownDataViewModelItem
//{
//    var type: GownViewModelItemType
//    {
//        return .displayName
//    }
//    
//    var sectionTitle: String
//    {
//        return "User"
//    }
//    
//    var name: String
//    
//    init(displayName: String)
//    {
//        self.name = displayName
//    }
//}
//
//class GownDataPriceItem: GownDataViewModelItem
//{
//    var type: GownViewModelItemType
//    {
//        return .price
//    }
//    
//    var sectionTitle: String
//    {
//        return "Price Range"
//    }
//    
//    var priceOne: Int
//    
//    init(price: Int)
//    {
//        self.priceOne = price
//    }
//}
//
//class GownDataColorItem: GownDataViewModelItem
//{
//    var type: GownViewModelItemType
//    {
//        return .color
//    }
//    
//    var sectionTitle: String
//    {
//        return "Color"
//    }
//    
//    var color: String
//    
//    init(dressColor: String)
//    {
//        self.color = dressColor
//    }
//}
//
//class GownDataDescriptionItem: GownDataViewModelItem
//{
//    var type: GownViewModelItemType
//    {
//        return .description
//    }
//    
//    var sectionTitle: String
//    {
//        return "Description"
//    }
//    
//    var description: String
//    
//    init(dressDescription: String)
//    {
//        self.description = dressDescription
//    }
//}
//
//class GownDataMeasurementItem: GownDataViewModelItem
//{
//    var type: GownViewModelItemType
//    {
//        return .measurements
//    }
//    
//    var sectionTitle: String
//    {
//        return "Measurements"
//    }
//    
//    var measurements: String
//    
//    init(dressMeasurements: String)
//    {
//        self.measurements = dressMeasurements
//    }
//}
//
//class GownViewModel: NSObject
//{
//    var items = [GownDataViewModelItem]()
//    
//    override init()
//    {
//        super.init()
//        let gownObj = Gown()
//        
//        
//        if let title = gownObj.title
//        {
//            let gownTitle = GownDataModelNameItem(title: title)
//            items.append(gownTitle)
//        }
//        
//        if let price = gownObj.priceRange1
//        {
//            let gownPrice = GownDataPriceItem(price: price)
//            items.append(gownPrice)
//        }
//        
//        if let color = gownObj.color
//        {
//            let gownColor = GownDataColorItem(dressColor: color)
//            items.append(gownColor)
//        }
//        
//        if let description = gownObj.description
//        {
//            let gownDesc = GownDataDescriptionItem(dressDescription: description)
//            items.append(gownDesc)
//        }
//    }
//}
//
//extension GownViewModel: UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items[section].rowCount
//
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return items.count
//    }
//}


