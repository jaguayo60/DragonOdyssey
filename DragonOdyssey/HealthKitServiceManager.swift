//
//  HealthKitServiceManager.swift
//  DragonOdyssey
//
//  Created by Jared on 10/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitServiceManager: NSObject {
    
    // MARK: - Instance variables
    
    static let shared = HealthKitServiceManager()
    
    var dietaryWaterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)
    var activitySummaryType = HKActivitySummaryType.activitySummaryType()
    
    lazy var healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else { return nil }
    }()
    
    // MARK: - Querying
    
    func queryActivitySummary() {
        let predicate = activitySummaryPredicate()
        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summariesOrNil, errorOrNil) -> Void in
            
            guard let summaries = summariesOrNil else {
                // Handle any errors here.
                return
            }
            
            for summary in summaries {
                print(summary)
                // Process each summary here.
            }
            
            // The results come back on an anonymous background queue.
            // Dispatch to the main queue before modifying the UI.
            
            DispatchQueue.main.async {
                // Update the UI here.
            }
        }
        
        healthStore?.execute(query)
    }
    
    private func activitySummaryPredicate() -> NSPredicate {
        let calendar = NSCalendar.current
        let endDate = Date()
        
        guard let startDate = calendar.date(byAdding: .day, value: -7, to: endDate) else {
            fatalError("*** Unable to create the start date ***")
        }
        
        let units: Set<Calendar.Component> = [.day, .month, .year, .era]
        
        var startDateComponents = calendar.dateComponents(units, from: startDate)
        startDateComponents.calendar = calendar
        
        var endDateComponents = calendar.dateComponents(units, from: endDate)
        endDateComponents.calendar = calendar
        
        // Create the predicate for the query
        let summariesWithinRange = HKQuery.predicate(forActivitySummariesBetweenStart: startDateComponents, end: endDateComponents)
        return summariesWithinRange
    }
    
    // MARK: - Writing
    
//    func createAndSaveSampleFor(drink: sdDrink) {
//        guard let healthStore = healthStore,
//            let date = drink.date,
//            let type = dietaryWaterType,
//            let drinkTypeID = drink.drinkType?.imageName
//            else { return }
//
//        let coefficientPercent = DrinkTypesLibrary.drinkTypeCoefficientPercentFor(drinkTypeID: drinkTypeID)
//        let netWaterOunces = drink.ounces * coefficientPercent
//
//        let startDate = date
//        let endDate = date.addingTimeInterval(1)
//
//        let ouncesQuantity = HKQuantity(unit: .fluidOunceUS(), doubleValue: Double(netWaterOunces))
//        let sample = HKQuantitySample(type: type, quantity: ouncesQuantity, start: startDate, end: endDate)
//
//        healthStore.save(sample, withCompletion: { (success, error) in
//            if success == true {
//            }
//            else {
//                print(error ?? "")
//            }
//        })
//    }
    
    // MARK: - Permission
    
    func requestWriteAccess(completion:(()->Void)? = nil) {
        guard let type = dietaryWaterType else { return }
        healthStore?.requestAuthorization(toShare: [type], read: nil, completion: { (success, error) in
            if completion != nil { completion!() }
        })
    }
    
    func requestReadAccess(completion:(()->Void)? = nil) {
        healthStore?.requestAuthorization(toShare: nil, read: [activitySummaryType], completion: { (success, error) in
            if completion != nil { completion!() }
        })
    }

    var appleHealthAuthorizationStatus: HKAuthorizationStatus? {
        guard let type = dietaryWaterType else { return nil }
        
        let status = healthStore?.authorizationStatus(for: type)
        return status
    }
}
