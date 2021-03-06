//
//  HomeVC.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class HomeVC: GLVC {

    // MARK: - IBOutlets
    
    @IBOutlet weak var levelTitleL: UILabel!
    @IBOutlet weak var levelProgressV: GLProgressV!
    @IBOutlet weak var stepsRemainingL: UILabel!
    
    @IBOutlet weak var energyProgressV: GLProgressV!
    @IBOutlet weak var energyAmountL: UILabel!
    
    // MARK: - Instance variables
    
//    let creature = CreatureService.creature
    
    var isVisible: Bool {
        // validate if vc is visible here...
        return true
    }
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Delete Core Data
//        NotificationCenter.default.addObserver(self, selector: #selector(self.coreDataManagerControllerDidChangeContent), name: NSNotification.Name(rawValue: "CoreDataManager_controllerDidChangeContent"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.outsideDataSynced), name: NSNotification.Name(rawValue: <#notificationName#>), object: nil)
        
        drawInitialUI()
        drawStaticUI()
    }
    
    var viewDidAppearLastCalled: Date?
    
    override func viewDidAppear(_ animated: Bool) {
        // Prevent viewDidAppear from being called twice
        if let viewDidAppearLastCalled = viewDidAppearLastCalled
        {
            let secondsSinceLastCalled = -viewDidAppearLastCalled.timeIntervalSinceNow
            if secondsSinceLastCalled < 0.5 { return }
        }
        
        super.viewDidAppear(animated)
        viewDidAppearLastCalled = Date()
        
        drawAnimatedUI()
    }
    
    // MARK: - UI
    
    func drawInitialUI() {
        levelProgressV.progressBarVColor = #colorLiteral(red: 0.4284983277, green: 0.9816996455, blue: 0.5134830475, alpha: 1)
        energyProgressV.progressBarVColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    }
    
    func drawStaticUI() {
        //TODO: redo this
//        stepsRemainingL.text = "\(creature.stepsRemainingToNextLevel.formattedWithSeparator) Steps Remaining"
//        levelTitleL.text = "Level \(Int(creature.level))"
//        energyAmountL.text = "\(Int(creature.energy))/\(Int(creature.totalEnergy))"
    }
    
    func stageAnimatedUI() {
        
    }
    
    func drawAnimatedUI(animated: Bool = true) {
        //TODO: Redo this
//        levelProgressV.setProgressTo(percent: creature.percentageOfLevelComplete, animated: true)
//        energyProgressV.setProgressTo(percent: creature.percentageOfEnergyAvailable, animated: true)
    }
    
    // MARK: - Data Responding
    
    //TODO: Delete core data
//    @objc func coreDataManagerControllerDidChangeContent(notification: NSNotification) {
//        drawStaticUI()
//        if self.isVisible { drawAnimatedUI() }
//    }
    
    @objc func outsideDataSynced(notification: NSNotification) {
        drawStaticUI()
        if self.isVisible { drawAnimatedUI() }
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shop(_ sender: Any) {
        let vc = InventoryVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func stats(_ sender: Any) {
        let vc = StatsVC()
        present(vc, animated: true, completion: nil)
    }
    
    @available(iOS 13.0, *)
    @IBAction func world(_ sender: Any) {
        let sb = UIStoryboard(name: "WorldSB", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "WorldVC") as WorldVC
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}
