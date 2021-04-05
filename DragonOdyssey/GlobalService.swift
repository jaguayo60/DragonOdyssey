//
//  GlobalService.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class GlobalService: NSObject
{
    static let appStoreLink = ""
    
    // MARK: - First Launch
    
//    static func firstLaunchActions() {
//        setFirstLaunchDate()
//        setFirstVersion()
//    }
    
//    private static func setFirstLaunchDate() {
//        guard FunctionService.userDefaultsGet(objectForKey: "firstLaunchDate") == nil else { return }
//        FunctionService.userDefaultsSet(object: Date(), key: "firstLaunchDate")
//    }
    
//    private static func setFirstVersion() {
//        guard FunctionService.userDefaultsGet(objectForKey: "firstLaunchVersion") == nil,
//            let currentAppVersionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//        else { return }
//        FunctionService.userDefaultsSet(object: currentAppVersionString, key: "firstLaunchVersion")
//    }
    
    // MARK: - Misc
    
    static func firstVersionString(firstVersionString: String, isPriorToSecondVersionString secondVersionsString: String) -> Bool? {
        guard let firstVersionInt = firstVersionString.replacingOccurrences(of: ".", with: "").toInt(),
            let secondVersionInt = secondVersionsString.replacingOccurrences(of: ".", with: "").toInt()
            else { return nil }
        
        return firstVersionInt < secondVersionInt
    }
    
    static func versionStringIsPriorToCurrentAppVersion(versionString: String) -> Bool? {
        guard let versionInt = versionString.replacingOccurrences(of: ".", with: "").toInt(),
            let currentAppVersionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let currentAppVersionInt = currentAppVersionString.replacingOccurrences(of: ".", with: "").toInt()
            else { return nil }
        
        return versionInt < currentAppVersionInt
    }
}
