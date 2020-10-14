//
//  TimingManager.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class TimingManager: NSObject {
    
    // MARK: - Instance variables
    
    static let shared = TimingManager()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - AppDelegate
    
    var appDelegate_applicationDidEnterBackground_fromBackground_wasCalled: Bool = false {
        didSet {
            if DebugService.logTimingActions == true { print("⏱ appDelegate_applicationDidEnterBackground_fromBackground_wasCalled valed changed to: \(appDelegate_applicationDidEnterBackground_fromBackground_wasCalled)") }
            
            // reset calls when app is minimized to prepare for proper execution upon app being resumed
            appDelegate_applicationDidBecomeActive_fromBackground_wasCalled = false
            fetchAndStoreExternalNotice_completed = false
            fetchAndStoreExternalPromo_completed = false
            fetchAndStoreExternalUpdate_completed = false
        }
    }
    
    var applicationDidBecomeActiveWasCalledRecently: Bool {
        guard let lastCalledDate = appDelegate.applicationDidBecomeActiveLastCalledDate else { return false }
        return -lastCalledDate.timeIntervalSinceNow < 3 // true if called in the last 3 seconds
    }
    
    var appDelegate_applicationDidBecomeActive_fromBackground_wasCalled: Bool = false {
        didSet {
            if DebugService.logTimingActions == true { print("⏱ appDelegate_applicationDidBecomeActive_fromBackground_wasCalled valed changed to: \(appDelegate_applicationDidBecomeActive_fromBackground_wasCalled)") }
            if appDelegate_applicationDidBecomeActive_fromBackground_wasCalled == false { return } // prevent code execution when resetting flags
            
            FunctionService.userDefaultsSet(object: Date(), key: "appDelegate_applicationDidBecomeActive_fromBackground_lastCalledDate")
            
//            NoticeServiceManager.shared.fetchAndStoreExternalNotice()
//            PromoServiceManager.shared.fetchAndStoreExternalPromo()
//            UpdateServiceManager.shared.fetchAndStoreExternalUpdate()
        }
    }
    
    var applicationDidBecomeActive_fromBackground_calledRecently: Bool {
        guard let lastCalledDate = FunctionService.userDefaultsGet(objectForKey: "appDelegate_applicationDidBecomeActive_fromBackground_lastCalledDate") as? Date else { return false }
        return Date().timeIntervalSince(lastCalledDate) <= 5 // true if function was called in the last 5 seconds
    }
    
    // MARK: - Connectivity
    
    var fetchAndStoreExternalNotice_completed: Bool = false {
        didSet {
            if DebugService.logTimingActions == true { print("⏱ fetchAndStoreExternalNotice_completed valed changed to: \(fetchAndStoreExternalNotice_completed)") }
            if fetchAndStoreExternalNotice_completed == false { return } // prevent code execution when resetting flags
            
            tryToPresentDidBecomeActiveAnnouncement()
        }
    }
    
    var fetchAndStoreExternalPromo_completed: Bool = false {
        didSet {
            if DebugService.logTimingActions == true { print("⏱ fetchAndStoreExternalPromo_completed valed changed to: \(fetchAndStoreExternalPromo_completed)") }
            if fetchAndStoreExternalPromo_completed == false { return } // prevent code execution when resetting flags
            
            tryToPresentDidBecomeActiveAnnouncement()
        }
    }
    
    var fetchAndStoreExternalUpdate_completed: Bool = false {
        didSet {
            if DebugService.logTimingActions == true { print("⏱ fetchAndStoreExternalUpdate_completed valed changed to: \(fetchAndStoreExternalUpdate_completed)") }
            if fetchAndStoreExternalUpdate_completed == false { return } // prevent code execution when resetting flags
            
            tryToPresentDidBecomeActiveAnnouncement()
        }
    }
    
    // MARK: - StoreKit
    
    var storeKitService_retrieveProducts_completed: Bool = false {
        didSet {
            if DebugService.logTimingActions == true { print("⏱ storeKitService_retrieveProducts_completed valed changed to: \(storeKitService_retrieveProducts_completed)") }
            tryToPresentDidBecomeActiveAnnouncement()
        }
    }
    
    // MARK: - VCs
    
    var appPVCContainingVC_viewDidLoad_wasCalled: Bool = false {
        didSet {
            if DebugService.logTimingActions == true { print("⏱ appPVCContainingVC_viewDidLoad_wasCalled valed changed to: \(appPVCContainingVC_viewDidLoad_wasCalled)") }
            tryToPresentDidBecomeActiveAnnouncement()
        }
    }
    
    // MARK: - Actions
    
    func tryToPresentDidBecomeActiveAnnouncement() {
        guard
            appDelegate_applicationDidBecomeActive_fromBackground_wasCalled == true,
            appPVCContainingVC_viewDidLoad_wasCalled == true,
            
            storeKitService_retrieveProducts_completed == true,
            
            fetchAndStoreExternalNotice_completed == true,
            fetchAndStoreExternalPromo_completed == true,
            fetchAndStoreExternalUpdate_completed == true,
            
            // statement will execute only after all the above conditions have been met, thus executing at the end of the race
            
            applicationDidBecomeActive_fromBackground_calledRecently == true // limit execution to derive from didBecomeActive
            else { return }
        
//        UpdateServiceManager.shared.storeRelevantUpdateObject() // must be executed first
//        NoticeServiceManager.shared.storeHighestPriorityActiveNotice()
//        PromoServiceManager.shared.storeHighestPriorityActivePromoType()
            
        DispatchQueue.main.async {
//            AnnouncementServiceManager.showDidBecomeActiveAnnouncement()
        }
    }
}
