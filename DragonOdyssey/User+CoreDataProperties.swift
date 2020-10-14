//
//  User+CoreDataProperties.swift
//  
//
//  Created by Jared on 10/14/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var tokens: Double

}
