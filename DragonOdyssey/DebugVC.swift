//
//  DebugVC.swift
//  DragonOdyssey
//
//  Created by Jared on 11/6/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class DebugVC: GLVC {

    // MARK: - IBOutlets
    
    
    // MARK: - Instance variables
    
    
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawVC()
    }
    
    // MARK: - UI
    
    func drawVC() {
        
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func button05(_ sender: Any) {
        UserService.user.tokens += 10
        CoreDataService.saveContext()
    }
    
    @IBAction func button07(_ sender: Any) {
        CreatureService.creature.totalSteps += 2500
        CoreDataService.saveContext()
        
        if DebugService.logCreatureStats == true { print("🐲 Added \(2500) steps to total. Total steps: \(CreatureService.creature.totalSteps)") }
        
        CreatureService.creature.updateLevel()
    }
    
    @IBAction func button15(_ sender: Any) {
        print(CreatureService.creature)
    }
    
    @IBAction func button20(_ sender: Any) {
        HealthKitServiceManager.shared.requestReadAccess {
            StepCountService.addStepsSinceLastStepsAddedDate()
        }
    }
}
