//
//  CoreLocationManager.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 12/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import CoreLocation

class CoreLocationManager: NSObject {
    
    // MARK: - Instance variables
    
    static let shared = CoreLocationManager()
    let locationManager = CLLocationManager()
    
    //MARK: - Functions
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}
