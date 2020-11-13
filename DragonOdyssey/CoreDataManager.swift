//
//  CoreDataManager.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    // MARK: - Instance variables
    
    static let shared = CoreDataManager()
    
    var skipUpdating = false
    var managedObjectChangedValues: [String]?
    
    // MARK: - Class functions
    
    override init() {
        super.init()
        self.creaturesFRCFetch()
        self.usersFRCFetch()
    }
    
    //MARK: - NSFetchedResultsController
    
    lazy var creaturesFetchedResultsController: NSFetchedResultsController<Creature> = {

        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<Creature>(entityName: "Creature")

        // Add Sort Descriptor & Predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "level", ascending: false)]

        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.context, sectionNameKeyPath: nil, cacheName: nil)

        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()

    func creaturesFRCFetch() {
        do {
            try self.creaturesFetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }

    lazy var usersFetchedResultsController: NSFetchedResultsController<User> = {

        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<User>(entityName: "User")

        // Add Sort Descriptor & Predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "tokens", ascending: false)]

        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.context, sectionNameKeyPath: nil, cacheName: nil)

        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()

    func usersFRCFetch() {
        do {
            try self.usersFetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }
}

extension CoreDataManager: NSFetchedResultsControllerDelegate {
    // MARK: - NSFetchedResultsController Delegate Methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if skipUpdating == true { return }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        if skipUpdating == true { return }
        
        if let creature = anObject as? Creature { managedObjectChangedValues = Array(creature.changedValuesForCurrentEvent().keys) }
        if let user = anObject as? User { managedObjectChangedValues = Array(user.changedValuesForCurrentEvent().keys) }
        
//        // Days
//        if controller == daysFetchedResultsController {
//            let vcAbbreviation = "CoreDataManager"
//            let objectName = "Day"
//
////            if let drink = anObject as? Drink { managedObjectChangedValues = Array(drink.changedValuesForCurrentEvent().keys) }
////            if let user = anObject as? User { managedObjectChangedValues = Array(user.changedValuesForCurrentEvent().keys) }
//
//            switch type
//            {
//            case .insert:
////                if let day = anObject as? Day {
////                    if FunctionService.userDefaultsGet(boolForKey: "prefAppleHealthEnabled") == true {
////                        HealthKitServiceManager.shared.createAndSaveSampleFor(drink: day.sdDrinkObject)
////                    }
////                }
//                UIApplication.shared.applicationIconBadgeNumber = 0
//                UserService.dailyActivityTracker()
//
//                if DebugService.logDetailedCoreDataActions == true { print("📦 \(vcAbbreviation) : \(objectName) : Insert") }
//
//            case .update:
//                UIApplication.shared.applicationIconBadgeNumber = 0
//                if DebugService.logDetailedCoreDataActions == true { print("📦 \(vcAbbreviation) : \(objectName) : Update") }
//
//            case .delete:
////                if let day = anObject as? Day {
////                }
//                if DebugService.logDetailedCoreDataActions == true { print("📦 \(vcAbbreviation) : \(objectName) : Delete") }
//
//            case .move:
//                print("📦 \(vcAbbreviation) : \(objectName) : Move")
//
//            @unknown default: break
//            }
//        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        if skipUpdating == true { return }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if skipUpdating == true { return }
        
        // *** When a drink is saved, the quick drinks database is automatically updated, this cause the user object to update as well, thus causing this method to trigger twice.
//
//        if controller == usersFetchedResultsController
//        {
//            NotificationCenter.default.post(name: NSNotification.Name("CoreDataManager_user_controllerDidChangeContent"), object: nil)
//        }
//
//        if let changedValues = managedObjectChangedValues, changedValues.contains("quickDrinks") || changedValues.contains("unitsOfMeasure")
//        {
//            NotificationManager.shared.setNotificationCategories()
//        }
//
//        /* don't update if triggered by 'quickDrinks'
//        (this protects against updates triggering twice when drinks are recorded) */
//        if let changedValues = managedObjectChangedValues, !changedValues.contains("quickDrinks")
//        {
//            WAWidgetService.packAndSendData()
//            NotificationService.scheduleReminders()
//
            NotificationCenter.default.post(name: NSNotification.Name("CoreDataManager_controllerDidChangeContent"), object: nil)
//        }
        
        managedObjectChangedValues = [String]()
    }
}

