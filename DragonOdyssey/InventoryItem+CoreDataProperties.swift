//
//  InventoryItem+CoreDataProperties.swift
//  
//
//  Created by Jared on 10/30/20.
//
//

import Foundation
import CoreData


extension InventoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InventoryItem> {
        return NSFetchRequest<InventoryItem>(entityName: "InventoryItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var energyAmount: Double
    @NSManaged public var tokenCost: Double
    @NSManaged public var isAdOnly: Bool
    @NSManaged public var sortPriority: Double
    
    @NSManaged public var user: User?

}
