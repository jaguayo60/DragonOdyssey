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
}
