//
//  AppDelegate.swift
//  DragonOdyssey
//
//  Created by Jared on 10/6/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

//import Firebase
//import FirebaseMessaging
//import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    // MARK: - Instance variables
        
    var window: UIWindow?
    var appEnteredBackground = true
    var didFinishLaunchingWithOptionsLastCalled: Date?
    let hapticFeedbackManager = HapticFeedbackManager.shared
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        guard let authentication = user.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    @available(iOS 9.0, *)
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

        return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    // MARK: - Class functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool // Only executed on launch
    {
        didFinishLaunchingWithOptionsLastCalled = Date()
        
        // Firebase
//        FirebaseConfiguration.shared.setLoggerLevel(.min)
//        FirebaseApp.configure()
        
        // OneSignal
//        configureOneSignalWith(launchOptions: launchOptions)
        
        // Generation
//        TipService.generateTips()
        
        // User Preferences
//        UserService.setUserPreferenceDefaultValues()
        
        // First launch
//        GlobalService.firstLaunchActions()
        
        // Migration
//        MigrationService.runMigrationTasks() // must be executed after firstLaunchActions & Generation
        
        // Debug
        DebugService.didFinishLaunchingTasks()
        //TODO: delete core data
//        CoreDataService.debugModelUpdates()
        
        // Entry
//        EntryService.directEntry()

        // Set Notification Categories/Actions
//        NotificationManager.shared.setNotificationCategories()
        
        // 🤑 In-App purchases
//        StoreKitService.shared.didFinishLaunchingTasks()
        
        // ⚠️ Should move to a better place later!
        HealthKitServiceManager.shared.requestReadAccess {
            StepCountService.addStepsSinceLastStepsAddedDate()
        }
        
        //Core Location
        CoreLocationManager.shared.requestAuthorization()
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if K.Enums.loggedInUsing == .Facebook {
            LoginManager().logOut()
            print("Logged out of Facebook")
        } else if K.Enums.loggedInUsing == .Google {
            GIDSignIn.sharedInstance()?.signOut()
            print("Signed out of Google")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) // Executed when alert is shown & when application is minimized or closed
    {
        if DebugService.logDelegateEvents == true { print("•AppDelegate: applicationWillResignActive") }
    }

    func applicationDidEnterBackground(_ application: UIApplication) // Only executed when app is minimized or closed
    {
        appEnteredBackground = true
//        TimingManager.shared.appDelegate_applicationDidEnterBackground_fromBackground_wasCalled = true
        NotificationCenter.default.post(name: NSNotification.Name("AppDelegate_applicationDidEnterBackground"), object: nil)
        if DebugService.logDelegateEvents == true { print("•AppDelegate: applicationDidEnterBackground") }
    }

    func applicationWillEnterForeground(_ application: UIApplication) // Not executed on launch, only when app is resumed
    {
        NotificationCenter.default.post(name: NSNotification.Name("AppDelegate_applicationWillEnterForeground"), object: nil)
        if DebugService.logDelegateEvents == true { print("•AppDelegate: applicationWillEnterForeground") }
    }

    var applicationDidBecomeActiveLastCalledDate: Date?
    func applicationDidBecomeActive(_ application: UIApplication) // Executed on launch and whenever app is resumed
    {
        applicationDidBecomeActiveLastCalledDate = Date()
        if appEnteredBackground == true { applicationDidBecomeActive_fromBackground() }
        
        NotificationCenter.default.post(name: NSNotification.Name("AppDelegate_applicationDidBecomeActive"), object: nil)
        if DebugService.logDelegateEvents == true { print("•AppDelegate: applicationDidBecomeActive") }
    }
    
    func applicationDidBecomeActive_fromBackground() // Executed on launch and when app resumes from background, NOT when app resumes from alert
    {
        DebugService.didBecomeActiveTasks()
        
        // Sync widget data
//        WAWidgetService.syncData()
        
        // Schedule Notifications
//        NotificationService.scheduleReminders()
        
        // 🤑 In-App Purchases
//        StoreKitService.shared.verifyAllPremiumSubscriptions()

        // Fetch and add steps from Apple Health
        StepCountService.addStepsSinceLastStepsAddedDate()
        
        // Clear notifications
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()

        FuncService.userDefaultsSet(object: Date(), key: "lastAppOpenDate")

        appEnteredBackground = false // turn off to prevent applicationWillResignActive (alerts) from triggering applicationDidBecomeActive_fromBackground
        
//        TimingManager.shared.appDelegate_applicationDidBecomeActive_fromBackground_wasCalled = true
        NotificationCenter.default.post(name: NSNotification.Name("AppDelegate_applicationDidBecomeActive_fromBackground"), object: nil)
        if DebugService.logDelegateEvents == true { print("•AppDelegate: applicationDidBecomeActive_fromBackground") }
    }

    
    // MARK: - openApp Urls
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        if url.scheme == "open"
//        {
//            switch url.host
//            {
//            case "wwPremium":
//                if let topVC = WAUI.topMostViewController(), let premiumVCDelegate = WAUI.topMostVCAsPresentedVCDelegate {
//                    let popUpVC = PopUpVC(heading: "DRINK Widget", body: "While you can see your daily progress with the free version of the app, inputing drinks using the widget is a Premium only feature.", enableActionB: true, buttonTitle: "Upgrade to Premium", enableClose: true, warning: false, additionalActionButtons: nil, actionFunction: {
//                        PremiumVC.fetchProductsAndPresentPremiumVC(presentingVC: topVC, premiumVCDelegate: premiumVCDelegate)
//                    })
//                    WATransition.presentVC(dir: .flyViewIn, presentingVC: topVC, newVC: popUpVC)
//                }
//            case "wwAddDrink":
//                guard WAUI.topMostViewController() is AppPVCContainingVC, UIManager.shared.mainVC.isVisible == true else { break }
//                UIManager.shared.mainVC.newDrink(0)
//            default:
//                break
//            }
//        }
//        return true
//    }
    
    // MARK: - OneSignal
    
//    private func configureOneSignalWith(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//        //Remove this method to stop OneSignal Debugging
//        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
//
//        //START OneSignal initialization code
//        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: false]
//
//        // Replace 'YOUR_ONESIGNAL_APP_ID' with your OneSignal App ID.
//        OneSignal.initWithLaunchOptions(launchOptions,
//          appId: "b2c5215c-90c4-437d-997b-ea63b144ad33",
//          handleNotificationAction: nil,
//          settings: onesignalInitSettings)
//
//        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
//
//        // The promptForPushNotifications function code will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 6)
////        OneSignal.promptForPushNotifications(userResponse: { accepted in
////          print("User accepted notifications: \(accepted)")
////        })
//    }
}

// MARK: - Notification names

extension Notification.Name {
    static var signInGoogleCompleted: Notification.Name {
        return .init(#function)
    }
}
