//
//  MapService.swift
//  DragonOdyssey
//
//  Created by Jared on 12/4/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class MapService: NSObject {
    static func itemsStringFor(map: [String:Any]) -> String {
        guard let itemIDs = map["rewardItems"] as? [String] else { return "" }
        
        var itemDicts = [[String:Any]]()
        
        for itemID in itemIDs {
            guard let itemDict = InventoryItemsLibrary.itemDictWith(id: itemID) else { continue }
            itemDicts.append(itemDict)
        }
        
        var itemsString = ""
        var itemIDsAddedToString = [String]()
        
        for itemDict in itemDicts {
            guard let itemID = itemDict["id"] as? String,
                  let itemName = itemDict["name"] as? String,
                  itemIDsAddedToString.contains(itemID) == false
            else { continue }
            
            let number = numberOfItemsWith(id: itemID, inItemDicts: itemDicts)
            itemsString.append((itemsString == "") ? "\(number) x \(itemName)" : "\n\(number) x \(itemName)")
            itemIDsAddedToString.append(itemID)
        }
        return itemsString
    }
    
    private static func numberOfItemsWith(id: String, inItemDicts itemDicts: [[String:Any]]) -> Int {
        var number = 0
        for itemDict in itemDicts {
            guard let itemID = itemDict["id"] as? String else { continue }
            if id == itemID { number += 1 }
        }
        return number
    }
    
    static func giveUserItemsFor(map: [String:Any]) {
        guard let itemsArray = map["rewardItems"] as? [String] else { return }
        
        for item in itemsArray {
            InventoryItemService.giveUserInventoryItemWith(id: item, purchase: false, saveContext: false)
        }
        CoreDataService.saveContext()
    }
}
