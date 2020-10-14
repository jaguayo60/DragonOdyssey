//
//  HapticFeedbackManager.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class HapticFeedbackManager: NSObject {
    // MARK: - Instance variables
    
    static let shared = HapticFeedbackManager()

    var hfg = UINotificationFeedbackGenerator()
    
    // MARK: - Class functions
    
    override init() {
        super.init()
        hfg.prepare()
    }
    
    func triggerHapticFeedbackOfType(feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        // trigger haptic feedback
        hfg.notificationOccurred(feedbackType)
        
        // prepare generator
        hfg.prepare()
    }
}
