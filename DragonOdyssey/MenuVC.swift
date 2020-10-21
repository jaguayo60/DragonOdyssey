//
//  MenuVC.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class MenuVC: GLVC {

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

    @IBAction func screen3(_ sender: Any) {
        let vc = FeedbackVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func screen2(_ sender: Any) {
        let vc = HomeVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func screen7(_ sender: Any) {
        let vc = StatsVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func grantAppleHealthPermissions(_ sender: Any) {
        HealthKitServiceManager.shared.requestReadAccess()
        
//        switch HealthKitServiceManager.shared.appleHealthAuthorizationStatus {
//        case .notDetermined:
//            HealthKitServiceManager.shared.requestReadAccess()
//        case .sharingDenied:break
//        case .sharingAuthorized:break
//        default:
//        FunctionService.open(urlString: "x-apple-health://")
//        }
    }
}
