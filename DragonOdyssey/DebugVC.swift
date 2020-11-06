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
}
