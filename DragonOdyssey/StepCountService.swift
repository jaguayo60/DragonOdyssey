//
//  StepCountService.swift
//  DragonOdyssey
//
//  Created by Jared on 11/11/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class StepCountService: NSObject {
    
    static let creature = CreatureService.creature
    
    static func addStepsSinceLastStepsAddedDate() {
        
        var startDate = Date().midnight // if lastStepsAddedDate does not exist, set to start of today
        
        if let lastStepsAddedDate = FuncService.userDefaultsGet(objectForKey: "lastStepsAddedDate") as? Date {
            startDate = lastStepsAddedDate.addingTimeInterval(1) // add 1 second in case of sample landing exactly on lastStepsAddedDate and getting counted twice
        }

        if (Date().timeIntervalSince(startDate) / 60 / 60 / 24) > 3 { // Only search for data for up to 3 days in the past
            startDate = Date().plusNumberOfDays(numberOfDays: -3).midnight
        }
        
        HealthKitServiceManager.shared.fetchStepCountBetween(startDate: startDate, endDate: Date()) { (stepCount) in
            if stepCount == 0 {
                if DebugService.logCreatureStats == true { print("🐲 No new steps to add") }
                return
            }
            
            // guard against steps being added twice
            if let lastStepsAddedDate = FuncService.userDefaultsGet(objectForKey: "lastStepsAddedDate") as? Date {
                print("lastStepsAddedDate: \(lastStepsAddedDate)")
                print("interval since lastStepsAddedDate: \(Date().timeIntervalSince(lastStepsAddedDate))")
                guard Date().timeIntervalSince(lastStepsAddedDate) > 3 else { return }
            }
            
            creature.totalSteps += stepCount
            
            CoreDataService.saveContext()
            FuncService.userDefaultsSet(object: Date(), key: "lastStepsAddedDate")
            if DebugService.logCreatureStats == true { print("🐲 Added \(stepCount) steps to total. Total steps: \(CreatureService.creature.totalSteps)") }

            creature.updateLevel()
        }
    }
}
