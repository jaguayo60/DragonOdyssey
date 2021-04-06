//
//  StatsViewController.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 3/21/21.
//  Copyright © 2021 Wired Betterment. All rights reserved.
//

import UIKit
import MKRingProgressView

class StatsViewController: UIViewController {
    
    // MARK: - Variables
    
    var dailyAgility: Double = 0
    var dailyAgilityMax: Double = 1000
    var dailyAgilityPercent: Double {
        return Double(dailyAgility) / Double(dailyAgilityMax)
    }
    var dailyStrength: Double = 0
    var dailyStrengthMax: Double = 30
    var dailyStrengthPercent: Double {
        return Double(dailyStrength) / Double(dailyStrengthMax)
    }
    var dailyTokens: Double = 0
    var dailyTokensMax: Double = 10
    var dailyTokensPercent: Double {
        return Double(dailyTokens) / Double(dailyTokensMax)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var tokensLabel: UILabel!
    @IBOutlet weak var progressGroup: RingProgressGroupView!
    @IBOutlet weak var agilityProgressV: GLProgressV!
    @IBOutlet weak var strengthProgressV: GLProgressV!
    @IBOutlet weak var lowerAgilityLabel: UILabel!
    @IBOutlet weak var lowerStrengthLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchActivitySummaryAndUpdateUI()
    }
    
    private func setup() {
        agilityProgressV.progressBarVColor = #colorLiteral(red: 1, green: 0.3778498536, blue: 0.3882190227, alpha: 1)
        strengthProgressV.progressBarVColor = #colorLiteral(red: 0.202904135, green: 0.9786005616, blue: 0.323242873, alpha: 1)
    }
    
    private func updateActivityRings(animated: Bool = true) {
        if animated == true {
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
                self.progressGroup.ring1.progress = self.dailyAgilityPercent
                self.progressGroup.ring2.progress = self.dailyStrengthPercent
                self.progressGroup.ring3.progress = self.dailyTokensPercent
            }, completion: nil)
        }
    }
    
    // MARK: - Activity Summary
    
    private func fetchActivitySummaryAndUpdateUI() {
//        HealthKitServiceManager.shared.fetchActivitySummariesBetween(startDate: Date(), endDate: Date()) { (summariesOrNil) in
//            guard let summary = summariesOrNil?.first else { return }
//            self.dailyAgility = summary.caloriesBurned
//            self.dailyStrength = summary.workoutMinutes
//            self.dailyTokens = summary.standingHours
//
//            DispatchQueue.main.async {
//                self.updateActivityRings()
//            }
//        }
    }

}
