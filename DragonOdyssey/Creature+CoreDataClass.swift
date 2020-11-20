//
//  Creature+CoreDataClass.swift
//  
//
//  Created by Jared on 10/14/20.
//
//

import Foundation
import CoreData
import UIKit

@objc(Creature)
public class Creature: NSManagedObject {
    var levelDicForCurrentLevel: [String:Any]? {
        return CreatureLevelLibrary.creatureLevelDicts[Int(level)]
    }
    
    var totalStepsForCurrentLevel: Int? {
        return levelDicForCurrentLevel?["totalStepsForLevel"] as? Int
    }
    
    var stepsToNextLevel: Int? {
        return levelDicForCurrentLevel?["stepsToNextLevel"] as? Int
    }
    
    var stepsIntoLevel: Int { // ex: 5,200 total steps, level 1 takes 5,000 steps, 200 steps into level
        return Int(totalSteps) - (totalStepsForCurrentLevel ?? 0)
    }
    
    var stepsRemainingToNextLevel: Int {
        guard let stepsToNextLevel = stepsToNextLevel else { return 0 }
        return stepsToNextLevel - stepsIntoLevel
    }
    
    var energyLeftBeforeMax: Int { // example 10/15, 5 energyLeftBeforeMax
        return (totalEnergy - energy) >= 0 ? Int(totalEnergy - energy) : 0
    }
    
    var percentageOfLevelComplete: CGFloat {
        guard let stepsToNextLevel = stepsToNextLevel else { return 0 }
        return CGFloat(stepsIntoLevel) / CGFloat(stepsToNextLevel)
    }
    
    var percentageOfEnergyAvailable: CGFloat {
        guard totalEnergy > 0 else { return 0 } // guard against divising by 0
        return CGFloat(energy / totalEnergy)
    }
    
    func updateLevel() {
        for levelDict in CreatureLevelLibrary.creatureLevelDicts {
            guard let totalStepsForLevel = levelDict["totalStepsForLevel"] as? Int,
                  let stepsToNextLevel = levelDict["stepsToNextLevel"] as? Int,
                  let level = levelDict["level"] as? Int,
                  let maxEnergy = levelDict["maxEnergy"] as? Int
            else { continue }
            
            if Int(totalSteps) >= totalStepsForLevel && Int(totalSteps) < (totalStepsForLevel + stepsToNextLevel) {
                self.level = Double(level)
                self.totalEnergy = Double(maxEnergy)
                CoreDataService.saveContext()
                
                if DebugService.logCreatureStats == true { print("🐲 Updated creature level to Level \(level)") }
            }
        }
    }
}
