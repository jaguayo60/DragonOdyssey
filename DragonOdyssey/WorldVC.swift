//
//  WorldVC.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 12/28/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

typealias CLManager = CoreLocationManager

class WorldVC: UIViewController {
    
    //MARK: - Variables
    
    let locationManager = CLManager.shared.locationManager

    //MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    
    //MARK: - Actions
    
    @IBAction func xButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        initDelegates()
        initLocationManager()
    }
    
    func initDelegates() {
        locationManager.delegate = self

    }
    
    func initLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - NavBar
    
    func setupNavBar() {
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

    }

}

//MARK: - CLManager Delegate

extension WorldVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
