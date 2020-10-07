//
//  FuncService.swift
//  DragonOdyssey
//
//  Created by Jared on 10/6/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import StoreKit

class FuncService: NSObject
{
    // MARK: - User Defaults
    
    // set
    
    @objc class func userDefaultsSet(object: Any, key: String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func userDefaultsSet (bool: Bool, key: String)
    {
        UserDefaults.standard.set(bool, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    // get
    
    class func userDefaultsGet(boolForKey key: String) -> Bool
    {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    @objc class func userDefaultsGet(objectForKey key: String) -> Any?
    {
        let test = UserDefaults.standard.object(forKey: key)
        
        return (test == nil) ? nil : test as Any
    }
    
    // remove/nil
    
    @objc class func userDefaultsRemoveObjectForKey(key: String)
    {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    // MARK: - UI
    
    class var rootVC: UIViewController?
    {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        return rootVC
    }
    
    class var topViewController: UIViewController?
    {
        guard let rootVC = rootVC else { return nil }
        return topViewController(rootVC: rootVC)
    }
    
    class func topViewController(rootVC: UIViewController) -> UIViewController
    {
        if rootVC.presentedViewController == nil {
            return rootVC
        }
        if type(of: rootVC.presentedViewController) == UINavigationController.self
        {
            let navigationController: UINavigationController? = (rootVC.presentedViewController as? UINavigationController)
            let lastViewController: UIViewController? = navigationController?.viewControllers.last
            return topViewController(rootVC: lastViewController!)
        }
        let presentedViewController: UIViewController? = (rootVC.presentedViewController)
        return topViewController(rootVC: presentedViewController!)
    }
    
    // MARK: - Alerts
    
    class func showBasicAlert(title: String?, message: String, btnTitle: String, action: UIAlertAction?, controller : UIViewController?)
    {
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        let alertAction: UIAlertAction = (action != nil) ? action! : UIAlertAction(title: btnTitle, style: .default, handler: nil)
        alert.addAction(alertAction)
        
        controller?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delay
    
    enum DispatchLevel
    {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
    
    class func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    // MARK: - URLs
    
    class func open(urlString: String)
    {
        guard let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - User Feedback
    
    @objc class func requestReview()
    {
        // check to see if there is a requestReviewLastShown date
        if let requestReviewLastShownDate = userDefaultsGet(objectForKey: "requestReviewLastShown") as? Date
        {
            // check to see if it was more than a day ago
            if requestReviewLastShownDate.numberOfDaysInBetweenSelfAndDate(date: Date()) > 0
            {
                showRequestReviewPopUp()
            }
        }
        else
        {
            showRequestReviewPopUp()
        }
    }
    
    class func showRequestReviewPopUp()
    {
//        guard UserService.user.daysActive >= 4 else { return }
        
        if #available(iOS 10.3, *)
        {
            SKStoreReviewController.requestReview()
            userDefaultsSet(object: Date(), key: "requestReviewLastShown")
        }
    }
}
