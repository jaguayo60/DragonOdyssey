//
//  Creature+CoreDataProperties.swift
//  
//
//  Created by Jared on 10/14/20.
//
//

import Foundation
import CoreData


extension Creature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Creature> {
        return NSFetchRequest<Creature>(entityName: "Creature")
    }

    @NSManaged public var energy: Double
    @NSManaged public var level: Double
    @NSManaged public var totalSteps: Double
    @NSManaged public var agility: Double
    @NSManaged public var strength: Double

}
