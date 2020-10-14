//
//  GLVC.swift
//  HarmLess
//
//  Created by Jared on 9/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class GLVC: UIViewController
{
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override var prefersStatusBarHidden: Bool {
        if UIService.deviceScreenSize == ._4In { // IPhone 5/SE
            return true
        }
        else { return false }
    }
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = .overFullScreen
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light } // Force out of dark mode
    }
}
