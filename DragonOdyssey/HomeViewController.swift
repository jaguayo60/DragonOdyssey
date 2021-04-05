//
//  HomeViewController.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 3/21/21.
//  Copyright © 2021 Wired Betterment. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgressBar: GLProgressV!
    @IBOutlet weak var stepsRemainingLabel: UILabel!
    @IBOutlet weak var energyProgressBar: GLProgressV!
    @IBOutlet weak var energyLevelLabel: UILabel!
    
    // MARK: - IBActions
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        //TODO: set all 5 outlets
        //get total steps, calculate steps remaining for next level
        //get energy max & current level
        
    }

}
