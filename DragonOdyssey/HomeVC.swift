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
    
    var isVisible: Bool {
        // validate if vc is visible here...
        return true
    }
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.coreDataManagerControllerDidChangeContent), name: NSNotification.Name(rawValue: "CoreDataManager_controllerDidChangeContent"), object: nil)
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
        
    }
    
    func stageAnimatedUI() {
        
    }
    
    func drawAnimatedUI(animated: Bool = true) {
        levelProgressV.setProgressTo(percent: 0.25, animated: true)
        energyProgressV.setProgressTo(percent: 0.6, animated: true)
    }
    
    // MARK: - Data Responding
    
    @objc func coreDataManagerControllerDidChangeContent(notification: NSNotification) {
        drawStaticUI()
        if self.isVisible { drawAnimatedUI() }
    }
    
    @objc func outsideDataSynced(notification: NSNotification) {
        drawStaticUI()
        if self.isVisible { drawAnimatedUI() }
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func settings(_ sender: Any) {
        let vc = SettingsVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func shop(_ sender: Any) {
        let vc = InventoryVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func stats(_ sender: Any) {
        let vc = StatsVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func hunt(_ sender: Any) {
        
    }
}
