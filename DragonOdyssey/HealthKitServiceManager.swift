//
//  HealthKitServiceManager.swift
//  DragonOdyssey
//
//  Created by Jared on 10/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

//import UIKit
//import HealthKit
//
//class ActivitySummary: NSObject {
//
//    // MARK: - Instance variables
//
//    let date: Date
//    let caloriesBurned: Double
//    let workoutMinutes: Double
//    let standingHours: Double
//
//    // MARK: - Class functions
//
//    init(date: Date, caloriesBurned: Double, workoutMinutes: Double, standingHours: Double) {
//        self.date = date
//        self.caloriesBurned = caloriesBurned
//        self.workoutMinutes = workoutMinutes
//        self.standingHours = standingHours
//    }
//}

//class HealthKitServiceManager: NSObject {
//
//    // MARK: - Instance variables
//
//    static let shared = HealthKitServiceManager()
//
////    var dietaryWaterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)
//    private var stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)
//    private var activitySummaryType = HKActivitySummaryType.activitySummaryType()
//
//    lazy var healthStore: HKHealthStore? = {
//        if HKHealthStore.isHealthDataAvailable() {
//            return HKHealthStore()
//        } else { return nil }
//    }()
    
    // MARK: - Querying
    
//    func fetchActivitySummariesBetween(startDate: Date, endDate: Date, completion: @escaping ([ActivitySummary]?) -> Void) {
//        let predicate = activitySummaryPredicateFor(startDate: startDate, endDate: endDate)
//
//        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summariesOrNil, errorOrNil) -> Void in
//
//            guard let summaries = summariesOrNil else {
//                // Handle any errors here.
//                completion(nil)
//                return
//            }
            
//            if DebugService.logDetailedHealthKitAction == true {
//                for summary in summaries {
//                    print("❤️ \(summary)")
//                }
//            }
            
//            if DebugService.logBasicHealthKitAction == true { print("❤️ Fetched \(summaries.count) activity summaries") }
            
//            DispatchQueue.main.async {
//                completion (self.activitySummariesFor(hkActivitySummaries: summaries))
//            }
//        }
//
//        healthStore?.execute(query)
//    }
    
//    private func activitySummaryPredicateFor(startDate: Date, endDate: Date) -> NSPredicate {
//        let calendar = NSCalendar.current
//        let endDate = Date()
//
//        guard let startDate = calendar.date(byAdding: .day, value: -7, to: endDate) else {
//            fatalError("*** Unable to create the start date ***")
//        }
        
//        let units: Set<Calendar.Component> = [.day, .month, .year, .era]
//
//        var startDateComponents = calendar.dateComponents(units, from: startDate)
//        startDateComponents.calendar = calendar
//
//        var endDateComponents = calendar.dateComponents(units, from: endDate)
//        endDateComponents.calendar = calendar
//
//        // Create the predicate for the query
//        let summariesWithinRange = HKQuery.predicate(forActivitySummariesBetweenStart: startDateComponents, end: endDateComponents)
//        return summariesWithinRange
//    }
    
//    func fetchStepCountBetween(startDate: Date, endDate: Date, completion: @escaping (Double) -> Void) {
//        fetchStepCountSamplesBetween(startDate: startDate, endDate: endDate, completion: { (samplesOrNil) in
//            guard let samples = samplesOrNil else { completion(0) ; return }
//
//            var totalSteps: Double = 0
//            for sample in samples {
//                guard let quantitySample = sample as? HKQuantitySample else { continue }
//                totalSteps += quantitySample.quantity.doubleValue(for: .count())
//            }
            
//            if DebugService.logBasicHealthKitAction == true { print("❤️ Step Count between \(startDate.stringWithFormat(formatString: "MMM d, h:mm a")) and \(endDate.stringWithFormat(formatString: "MMM d, h:mm a")) : \(totalSteps)") }
            
//            completion(totalSteps)
//        })
//    }
    
//    private func fetchStepCountSamplesBetween(startDate: Date, endDate: Date, completion: @escaping ([HKSample]?) -> Void) {
//        guard let stepCountType = stepCountType else { completion(nil) ; return }
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
//
//        let query = HKSampleQuery(sampleType: stepCountType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samplesOrNil, errorOrNil) in
//            guard let samples = samplesOrNil else { completion(nil) ; return }
            
//            if DebugService.logDetailedHealthKitAction == true {
//                for sample in samples {
//                    print("❤️ \(sample)")
//                }
//            }
            
//            if DebugService.logBasicHealthKitAction == true { print("❤️ Fetched \(samples.count) stepCount HKSamples") }
//
//            DispatchQueue.main.async {
//                completion (samples)
//            }
//        }

//        healthStore?.execute(query)
//    }
    
//    func retrieveStepCount(completion: @escaping (Double?) -> Void) {
//        guard let stepCountType = stepCountType else { completion(nil) ; return }
//
//        let startDate = Date().midnight.plusNumberOfDays(numberOfDays: -20)
//
//        //  Set the Predicates & Interval
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
//        var interval = DateComponents()
//        interval.day = 1
//
//        //  Perform the Query
//        let query = HKStatisticsCollectionQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents:interval)
//
//        query.initialResultsHandler = { query, results, error in
//
//            if error != nil {
//
//                //  Something went Wrong
//                return
//            }
//
//            if let myResults = results {
//                myResults.enumerateStatistics(from: Date().midnight, to: Date()) {
//                    statistics, stop in
//
//                    if let quantity = statistics.sumQuantity() {
//
//                        let steps = quantity.doubleValue(for: HKUnit.count())
//
//                        print("Steps = \(steps)")
//                        completion(steps)
//                    }
//                }
//            }
//        }
//        healthStore?.execute(query)
//    }
    
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
    
//    func requestWriteAccess(completion:(()->Void)? = nil) {
//        guard let type = dietaryWaterType else { return }
//        healthStore?.requestAuthorization(toShare: [type], read: nil, completion: { (success, error) in
//            if completion != nil { completion!() }
//        })
//    }
    
//    func requestReadAccess(completion:(()->Void)? = nil) {
//        guard let healthStore = healthStore, let stepCountType = stepCountType else { if completion != nil { completion!() } ; return }
//
//        healthStore.requestAuthorization(toShare: nil, read: [activitySummaryType, stepCountType], completion: { (success, error) in
//            if error != nil { print(error!) }
//            if completion != nil { completion!() }
//        })
//    }

//    var appleHealthAuthorizationStatus: HKAuthorizationStatus? {
//        guard let type = dietaryWaterType else { return nil }
//
//        let status = healthStore?.authorizationStatus(for: type)
//        return status
//    }
    
    // MARK: - Activity Summary
    
//    private func activitySummariesFor(hkActivitySummaries: [HKActivitySummary]) -> [ActivitySummary]? {
//        var activitySummaries = [ActivitySummary]()
//
//        for hkActivitySummary in hkActivitySummaries {
//            guard let date = hkActivitySummary.dateComponents(for: Calendar.current).date else { continue }
//            let caloriesBurned = hkActivitySummary.activeEnergyBurned.doubleValue(for: .kilocalorie())
//            let workoutMinutes = hkActivitySummary.appleExerciseTime.doubleValue(for: .minute())
//            let standingHours = hkActivitySummary.appleStandHours.doubleValue(for: .count())
//            activitySummaries.append(ActivitySummary(date: date, caloriesBurned: caloriesBurned, workoutMinutes: workoutMinutes, standingHours: standingHours))
//        }
//
//        return (activitySummaries.count > 0) ? activitySummaries : nil
//    }
//}
