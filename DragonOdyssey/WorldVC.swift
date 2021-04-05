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
    var mapViewManager = WorldManager()
    var isFirstRenderDone = false

    //MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var gameMapLabel: UILabel!
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToHome", sender: nil)
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupLocationManager()
        view.addSubview(backButton)
        view.addSubview(gameMapLabel)
    }
    
    func setupDelegates() {
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
    
    func addGridToMap(grid: [MKPolygon]) {
        for tile in grid {
            mapView.addOverlay(tile)
        }
    }
    
    func removeFromMap(overlays: [MKOverlay]) {
        for overlay in overlays {
            mapView.removeOverlay(overlay)
        }
    }
    
    func collisionDetection(location: CLLocation) {
        let overlaysToRemove = mapViewManager.checkForCollision(location: location)
        if overlaysToRemove.count > 0 {
            removeFromMap(overlays: overlaysToRemove)
        }
    }
    
}

//MARK: - CLManager Delegate

extension WorldVC: CLLocationManagerDelegate {
    
    //Whenever the Location Updates, this method is called
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !isFirstRenderDone {
            if let location = locations.first {
                mapViewManager.initGrid(location: location)
                collisionDetection(location: location)
                addGridToMap(grid: mapViewManager.grid)
                render(location)
                isFirstRenderDone = true
            }
        } else {
            let location = locations[locations.count - 1]
            collisionDetection(location: location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let mapCamera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 1000, pitch: 75, heading: 0)
        mapView.setCamera(mapCamera, animated: true)
    }
}

//MARK: - MapView Delegate

extension WorldVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonRenderer = MKPolygonRenderer(overlay: overlay)
            polygonRenderer.fillColor = UIColor.gray
            polygonRenderer.alpha = 1.0
            return polygonRenderer
        }
        
        return MKOverlayRenderer()
    }
}
