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
}
