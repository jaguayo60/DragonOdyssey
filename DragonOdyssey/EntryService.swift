//
//  EntryService.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class EntryService: NSObject {
    // MARK: - Class functions
    
    override init() {
        super.init()
    }
    
    enum UserEntryType { case newDay, dayStarted }
    
    class func directEntry() {
        let vc = MenuVC()
        UIApplication.shared.delegate?.window??.rootViewController = vc
    }
}
