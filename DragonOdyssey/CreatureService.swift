//
//  CreatureService.swift
//  DragonOdyssey
//
//  Created by Jared on 11/11/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import CoreData

class CreatureService: NSObject {
    
    // MARK: - Creation
    
    static var creature: Creature {
         if let creatures = fetchAllCreatureObjects() {
            if creatures.count > 1 {
                print("•WARNING: There is more than one creature object present.")
            }
            return creatures[0]
        }
        else {
            CoreDataManager.shared.skipUpdating = true
            let newCreature = Creature(context: CoreDataService.context)
            CoreDataService.saveContext()
            CoreDataManager.shared.skipUpdating = false
            return newCreature
        }
    }
    
    // MARK: - Fetching
    
    static func fetchAllCreatureObjects() -> [Creature]? {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<Creature>(entityName: "Creature")
        
        // Add Sort Descriptor & Predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "level", ascending: false)]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        if let creatures = fetchedResultsController.fetchedObjects {
            if creatures.count > 0 { return creatures}
        }
        return nil
    }
    
    // MARK: - Stats
}
