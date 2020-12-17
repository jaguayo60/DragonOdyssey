//
//  InventoryItemService.swift
//  DragonOdyssey
//
//  Created by Jared on 11/2/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import CoreData

class InventoryItemService: NSObject {
    
    // MARK: - Instance variables
    
    static let user = UserService.user
    
    // MARK: - Counts
    
    static func numberOfItemsInInventoryWith(id: String) -> Int {
        return fetchInventoryItemsWith(id: id)?.count ?? 0
    }
    
    // MARK: - Fetching
    
    static func fetchInventoryItemsWith(id: String) -> [InventoryItem]? {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<InventoryItem>(entityName: "InventoryItem")
        
        // Add Sort Descriptor
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "sortPriority", ascending: false)]
        
        // Add Predicate
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        if let items = fetchedResultsController.fetchedObjects {
            if items.count > 0 { return items }
        }
        return nil
    }
    
    // MARK: - Purchasing
    
    static func giveUserInventoryItemWith(id: String, purchase: Bool, saveContext: Bool? = true) {
        guard let itemDict = InventoryItemsLibrary.itemDictWith(id: id) else { return }
        let storedItem = InventoryItem(context: CoreDataService.context)
        
        storedItem.user = user
        if let id = itemDict["id"] as? String { storedItem.id = id }
        if let imageName = itemDict["imageName"] as? String { storedItem.imageName = imageName }
        if let name = itemDict["name"] as? String { storedItem.name = name }
        if let energyAmount = itemDict["energyAmount"] as? Double { storedItem.energyAmount = energyAmount }
        if let isAdOnly = itemDict["isAdOnly"] as? Bool { storedItem.isAdOnly = isAdOnly }
        if let tokenCost = itemDict["tokenCost"] as? Double { storedItem.tokenCost = tokenCost }
        if let sortPriority = itemDict["sortPriority"] as? Double { storedItem.sortPriority = sortPriority }
        
        if purchase == true { user.tokens = ((user.tokens - storedItem.tokenCost) >= 0) ? user.tokens - storedItem.tokenCost : 0 }
        if saveContext == true { CoreDataService.saveContext() }
    }
}
