//
//  UserService.swift
//  DragonOdyssey
//
//  Created by Jared on 11/2/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import CoreData

class UserService: NSObject {

    // MARK: - Creation
    
    static var user: User {
         if let users = fetchAllUserObjects() {
            if users.count > 1 {
                print("•WARNING: There is more than one user object present.")
            }
            return users[0]
        }
        else {
            CoreDataManager.shared.skipUpdating = true
            let newUser = User(context: CoreDataService.context)
            CoreDataService.saveContext()
            CoreDataManager.shared.skipUpdating = false
            return newUser
        }
    }
    
    // MARK: - Fetching
    
    static func fetchAllUserObjects() -> [User]? {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        // Add Sort Descriptor & Predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "tokens", ascending: false)]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        if let users = fetchedResultsController.fetchedObjects {
            if users.count > 0 { return users}
        }
        return nil
    }
}
