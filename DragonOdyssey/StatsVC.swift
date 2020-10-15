//
//  StatsVC.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class StatsVC: GLVC {

    // MARK: - IBOutlets
    
    @IBOutlet weak var dailyAgilityValueL: UILabel!
    @IBOutlet weak var dailyStrengthValueL: UILabel!
    @IBOutlet weak var dailyTokensValueL: UILabel!
    
    @IBOutlet weak var agilityProgressV: GLProgressV!
    @IBOutlet weak var agilityValueL: UILabel!
    @IBOutlet weak var strengthProgressV: GLProgressV!
    @IBOutlet weak var strengthValueL: UILabel!
    
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
        agilityProgressV.progressBarVColor = #colorLiteral(red: 1, green: 0.3778498536, blue: 0.3882190227, alpha: 1)
        strengthProgressV.progressBarVColor = #colorLiteral(red: 0.202904135, green: 0.9786005616, blue: 0.323242873, alpha: 1)
    }
    
    func drawStaticUI() {
        agilityValueL.text = "25/100"
        strengthValueL.text = "15/100"
    }
    
    func stageAnimatedUI() {
    }
    
    func drawAnimatedUI(animated: Bool = true) {
        agilityProgressV.setProgressTo(percent: 0.25, animated: true)
        strengthProgressV.setProgressTo(percent: 0.15, animated: true)
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
}
