//
//  GownViewModel.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 3/25/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import Foundation
import Firebase
import UIKit

enum GownViewModelItemType {
    case displayName, price, color, description
}

protocol GownDataViewModelItem {
    var type: GownViewModelItemType {get}
    var rowCount: Int {get}
    var sectionTitle: String {get}
}

//protocol GownViewModelDelegate
//{
//    func didRecieveGown(gown: Gown)
//}

class GownViewModel: NSObject
{
    var items = [GownDataViewModelItem]()
    var gownObj = Gown()
//    var delegate: GownViewModelDelegate
    
    override init()
    {
        super.init()
//        delegate.didRecieveGown(gown: gownObj)
        if let displayName = gownObj.poster
        {
            let gownDisplay = GownDataDisplayItem(displayName: displayName)
            items.append(gownDisplay)
        }
        
        if let price = gownObj.priceRange1
        {
            let gownPrice = GownDataPriceItem(price: price)
            items.append(gownPrice)
        }
        
        if let color = gownObj.color
        {
            let gownColor = GownDataColorItem(dressColor: color)
            items.append(gownColor)
        }
        
        if let description = gownObj.description
        {
            let gownDesc = GownDataDescriptionItem(dressDescription: description)
            items.append(gownDesc)
        }
    }
}


// Tableview Datasource
extension GownViewModel: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items[section].rowCount
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let item = items[indexPath.section]
        
        switch item.type
        {
        case .displayName:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_DISPLAYNAME_ID, for: indexPath) as? UserDisplayNameCell
            {
                cell.item = item
                return cell
            }
        case .price:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_PRICE_ID, for: indexPath) as?
                GownColorTableViewCell
            {
                cell.item = item
                return cell
            }
        case .color:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_COLOR_ID, for: indexPath) as?
                GownColorTableViewCell
            {
                cell.item = item
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_DESCRIPTION_ID, for: indexPath) as?
                GownDescriptionTableViewCell
            {
                cell.item = item
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
}

// ConfirmPostDelegate

//extension GownViewModel: ConfirmDressDelegate
//{
//    func didRecieveGown(gown: Gown) {
//        self.gownObj = gown
//    }
//}


// Tableview Item Work
class GownDataDisplayItem: GownDataViewModelItem
{
    var type: GownViewModelItemType
    {
        return .displayName
    }
    
    var sectionTitle: String
    {
        return "User"
    }
    
    var name: String
    
    init(displayName: String)
    {
        self.name = displayName
    }
}

class GownDataPriceItem: GownDataViewModelItem
{
    var type: GownViewModelItemType
    {
        return .price
    }
    
    var sectionTitle: String
    {
        return "Price Range"
    }
    
    var priceOne: Int
    
    init(price: Int)
    {
        self.priceOne = price
    }
}

class GownDataColorItem: GownDataViewModelItem
{
    var type: GownViewModelItemType
    {
        return .color
    }
    
    var sectionTitle: String
    {
        return "Color"
    }
    
    var color: String
    
    init(dressColor: String)
    {
        self.color = dressColor
    }
}

class GownDataDescriptionItem: GownDataViewModelItem
{
    var type: GownViewModelItemType
    {
        return .description
    }
    
    var sectionTitle: String
    {
        return "Description"
    }
    
    var description: String
    
    init(dressDescription: String)
    {
        self.description = dressDescription
    }
}

extension GownDataViewModelItem
{
    var rowCount: Int
    {
        return 1
    }
}
