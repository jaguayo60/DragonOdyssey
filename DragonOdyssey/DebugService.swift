//
//  DebugService.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

//import Firebase
//import FirebaseMessaging

class DebugService: NSObject
{
    static let debugMode = true
    static let blockFirebaseLogging = false
    
    static let premium = false
    static let bypassStoreKitFunctionality = false
    
    static let forceShowIntro = false
    static let alwaysShowAffirmations = false
    static let scheduleTestNotification = false
    
    // MARK: - Announcements
    static let announcementDebugMode = false
    static let resetWelcomeOfferOnLaunch = false
    static let ignoreWasShownFlags = false
    
    // MARK: - Logging
    static let logDelegateEvents = false
    static let logBasicDataCalculationEvents = false
    static let logAnimations = false
    static let logAllServableTips = false
    static let logAllTips = false
    static let logQuickDrinkData = false
    static let logBasicUserAnalytics = false
    static let logTimingActions = false
    static let logMigrationActions = false
    static let logFirebaseActions = false
    
    //❤️ HealthKit
    static let logBasicHealthKitAction = true
    static let logDetailedHealthKitAction = true
    
    //📦 Core Data
    static let logBasicCoreDataActions = true
    static let logDetailedCoreDataActions = true
    
    //↔️ Shared Data
    static let logBasicSharedDataActions = false
    static let logDetailedSharedDataActions = false
    
    //↔️ Connectivity
    static let logBasicConnectivityActions = false
    static let logDetailedConnectivityActions = false
    
    //🎉 Announcements
    static let logBasicAnnouncementActions = false
    static let logDetailedAnnouncementActions = false
    
    //🤑 StoreKit
    static let logBasicStoreKitActions = false
    static let logDetailedStoreKitActions = false
    
    // MARK: - Direct entry
    static let shouldDirectEntryToSpecificVC = false
    static func directEntryToSpecificVC() -> UIViewController {
        return UIViewController()
    }
    
    static func didFinishLaunchingTasks() {
        if debugMode == false { return } // only execute code when debug mode is enabled
//        if logFirebaseActions == true { print("FCM Token: \(Messaging.messaging().fcmToken ?? "")") }
    }
    
    static func didBecomeActiveTasks() {
        
//        if WADebug.logAllTips == true {
//            TipService.logAllTips()
//        }
    }
}
