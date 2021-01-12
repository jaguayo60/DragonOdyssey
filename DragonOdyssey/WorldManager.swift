//
//  WorldManager.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 1/11/21.
//  Copyright © 2021 Wired Betterment. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

struct WorldManager {
    
    var grid: [MKPolygon] = []
    let sizeOfTile: Double = 0.001
    
    //MARK: - init Grid
    
    mutating func initGrid(location: CLLocation) {
        let coord = location.coordinate
        let margin: Double = 0.01
        var squares: [MKPolygon] = []
        let startPoint: MKMapPoint = MKMapPoint(
                                        CLLocationCoordinate2D(
                                            latitude: (coord.latitude + margin),
                                            longitude: (coord.longitude - margin)))
        let endPoint: MKMapPoint = MKMapPoint(
                                        CLLocationCoordinate2D(
                                            latitude: (coord.latitude - margin),
                                            longitude: (coord.longitude + margin)))
        
        let sLat = startPoint.coordinate.latitude
        let sLon = startPoint.coordinate.longitude
        let eLat = endPoint.coordinate.latitude
        let eLon = endPoint.coordinate.longitude
        var latitude: Double = sLat
        var longitude: Double = sLon
        let latIncrement: Double = (sLat < eLat ? sizeOfTile : -sizeOfTile)
        let lonIncrement: Double = (sLon < eLon ? sizeOfTile : -sizeOfTile)
        
        while Int(latitude * (1 / margin) * 10) != Int((eLat + latIncrement) * (1 / margin) * 10) {
            longitude = sLon
            while Int(longitude * (1 / margin) * 10) != Int((eLon + lonIncrement) * (1 / margin) * 10) {
                let sPoint = MKMapPoint(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                let ePoint = MKMapPoint(CLLocationCoordinate2D(latitude: latitude + latIncrement, longitude: longitude + lonIncrement))
                let square = createSquare(startPoint: sPoint, endPoint: ePoint)
                squares.append(square)
                longitude += lonIncrement
            }
            latitude += latIncrement
        }
        
        print("Tiles in Grid: \(squares.count)")
        grid = squares
    }
    
    func createSquare(startPoint: MKMapPoint, endPoint: MKMapPoint) -> MKPolygon {
        var points = [MKMapPoint]()
        let sLat = startPoint.coordinate.latitude
        let sLon = startPoint.coordinate.longitude
        let eLat = endPoint.coordinate.latitude
        let eLon = endPoint.coordinate.longitude
        points.append(startPoint)
        points.append(MKMapPoint(CLLocationCoordinate2D(latitude: sLat, longitude: eLon)))
        points.append(endPoint)
        points.append(MKMapPoint(CLLocationCoordinate2D(latitude: eLat, longitude: sLon)))
        
        return MKPolygon(points: points, count: 4)
    }
    
    //MARK: - Collision Detection
    
    mutating func checkForCollision(location: CLLocation) -> [MKOverlay] {
        var overlaysToRemove: [MKOverlay] = []
        let userLat = location.coordinate.latitude
        let userLon = location.coordinate.longitude
        
        var index = 0
        //check all squares to see if they are colliding with the circle
        for square in grid {
            
            //find the point on the square that is closest to the circle point
            //  if the point is x distance away from the point, remove the whole square
            let point = closestPoint(point: location.coordinate, points: square.points())
            
            var lat = (userLat - point.latitude)
            if lat < 0 {lat *= -1}
            
            var lon = (userLon - point.longitude)
            if lon < 0 {lon *= -1}
            
            if (lat < 0.0009 && lon < 0.0012) || (lat < 0.0012 && lon < 0.0009) {
                overlaysToRemove.append(grid[index])
                grid.remove(at: index)
                index -= 1
                print("Lat: \(lat), Lon: \(lon)")
            }
            
            index += 1
        }
        
        return overlaysToRemove
    }
    
    //MARK: - Closest Point
    
    func closestPoint(point: CLLocationCoordinate2D, points: UnsafeMutablePointer<MKMapPoint>) -> CLLocationCoordinate2D {
        var pointList: [CLLocationCoordinate2D] = [points[0].coordinate,
                                                   points[1].coordinate,
                                                   points[2].coordinate,
                                                   points[3].coordinate]
        
        // if ALL of the points are to the LEFT of the point
        if pointList[0].latitude < point.latitude &&
            pointList[1].latitude < point.latitude &&
            pointList[2].latitude < point.latitude &&
            pointList[3].latitude < point.latitude {
            
            //find out which 2 points are closer
            pointList.sort(by: {$0.latitude < $1.latitude})
            
            //find out which point's longitude is closer
            let lon0 = abs(((point.longitude - pointList[0].longitude) * 10000))
            let lon1 = abs(((point.longitude - pointList[1].longitude) * 10000))
            
            //return the closer point
            return lon0 < lon1 ? pointList[0] : pointList[1]
        }
           
        // if ALL of the points are to the RIGHT of the point
        if pointList[0].latitude > point.latitude &&
            pointList[1].latitude > point.latitude &&
            pointList[2].latitude > point.latitude &&
            pointList[3].latitude > point.latitude {
            
            //find out which 2 points are closer
            pointList.sort(by: {$0.latitude > $1.latitude})
            
            //find out which point's longitude is closer
            let lon0 = abs(((point.longitude - pointList[0].longitude) * 10000))
            let lon1 = abs(((point.longitude - pointList[1].longitude) * 10000))
            
            //return the closer point
            return lon0 < lon1 ? pointList[0] : pointList[1]
        }
        
        // if ALL of the points are BELOW the point
        if pointList[0].longitude < point.longitude &&
            pointList[1].longitude < point.longitude &&
            pointList[2].longitude < point.longitude &&
            pointList[3].longitude < point.longitude {
            
            //find out which 2 points are closer
            pointList.sort(by: {$0.longitude < $1.longitude})
            
            //find out which point's latitude is closer
            let lon0 = abs(((point.latitude - pointList[0].latitude) * 10000))
            let lon1 = abs(((point.latitude - pointList[1].latitude) * 10000))
            
            //return the closer point
            return lon0 < lon1 ? pointList[0] : pointList[1]
        }
        
        // if ALL of the points are ABOVE the point
        if pointList[0].longitude > point.longitude &&
            pointList[1].longitude > point.longitude &&
            pointList[2].longitude > point.longitude &&
            pointList[3].longitude > point.longitude {
            
            //find out which 2 points are closer
            pointList.sort(by: {$0.longitude > $1.longitude})
            
            //find out which point's latitude is closer
            let lon0 = abs(((point.latitude - pointList[0].latitude) * 10000))
            let lon1 = abs(((point.latitude - pointList[1].latitude) * 10000))
            
            //return the closer point
            return lon0 < lon1 ? pointList[0] : pointList[1]
        }
        
        return pointList[0]
    }
}
