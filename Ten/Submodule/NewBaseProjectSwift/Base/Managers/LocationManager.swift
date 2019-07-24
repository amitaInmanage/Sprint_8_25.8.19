//
//  LocationManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: BaseManager, LocationUpdateableProtocol,CLLocationManagerDelegate {
    
    override init() {
        super.init()
        
        systemLocationManager.delegate = self
    }
    
    static var sharedInstance = LocationManager()
    
    let systemLocationManager = CLLocationManager()
    var arrUpdatableObjects   = [LocationUpdateableProtocol]()
    var currentLocation       : CLLocation?
    var currentHeading        = CLLocation()
    
    
    // Convenience method for creating a CLLocation
    func getLocationFromDict(locationDict: [String:Any]) -> (CLLocation?) {
        
        if locationDict.isEmpty {
            return nil
        }
        
        var lat,lon : Double
        
        lat = locationDict["lat"] as! Double
        lon = locationDict["lon"] as! Double
        
        let location = CLLocation(latitude: lat, longitude: lon)
        
        return location
    }
    
    // Location authorization
    func areLocationServicesAuthorizedInForeground() -> (Bool) {
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            return true
        }
        
        return false
    }
    
    
    func areLocationServicesAuthorizedInBackground() -> (Bool) {
        return (CLLocationManager.authorizationStatus() == .authorizedAlways)
    }
    
    
    //MARK: Location and Updateables
    
    // StartUpdatingLocation
    func startUpdatingLocationWithUpdateable(updateable: LocationUpdateableProtocol?) {
        
        self.systemLocationManager.distanceFilter = kCLDistanceFilterNone
        self.systemLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if iPhoneIOSVersion.IS_IOS_8_OR_LATER {
            //self.systemLocationManager.requestAlwaysAuthorization()
            self.systemLocationManager.requestWhenInUseAuthorization()
        }
        
        if let aUpdateable = updateable {
            self.addObjectToLocationUpdates(updateable: aUpdateable)
        }
        
        self.systemLocationManager.startUpdatingLocation()
        
    }
    
    // Location updateables handling
    func addObjectToLocationUpdates(updateable: LocationUpdateableProtocol) {
        
        weak var weakUpdateable = updateable
        
        if let aWeakUpdateable = weakUpdateable {
            
            self.arrUpdatableObjects.append(aWeakUpdateable)
            
        }
        
    }
    
    func removeObjectFromLocationUpdates(updateable: LocationUpdateableProtocol) {
        
        let index = (self.arrUpdatableObjects as NSArray).index(of: updateable)
        self.arrUpdatableObjects.remove(at: index)
        
    }
    
    func updateUpdateablesWithLocation(newLocation: CLLocation) {
        
        for updatable in self.arrUpdatableObjects {
            
            if updatable.responds(to: #selector(updatable.didGetNewLocation(location:))) {
                updatable.didGetNewLocation(location: newLocation)
            }
            
        }
        
    }
    
    func stopUpdatingLocationAndRemoveUpdateable(updateable: LocationUpdateableProtocol) {
        
        self.systemLocationManager.stopUpdatingLocation()
        
        let index = (self.arrUpdatableObjects as NSArray).index(of: updateable)
        self.arrUpdatableObjects.remove(at: index)
        
    }
    
    func stopUpdatingLocationAndClearUpdateables() {
        
        self.systemLocationManager.stopUpdatingLocation()
        self.arrUpdatableObjects.removeAll()
        
    }
    
    
    //MARK: Region Monitoring
    
    // Start region monitoring
    func startMonitoringRegionWithLocation(location: CLLocation, andRadius radius: Double, andIdentifier identifier: String) {
        
        let region : CLRegion? = CLCircularRegion(center: location.coordinate, radius: radius, identifier: identifier)
        
        if let aRegion = region {
            
            self.systemLocationManager.startMonitoring(for: aRegion)
            self.systemLocationManager.requestState(for: aRegion)
        }
    }
    
    // Stop region monitoring
    func stopMonitoringRegionWithIdentifier(identifier: String) {
        
        for region in self.systemLocationManager.monitoredRegions {
            if region.identifier == identifier {
                self.systemLocationManager.stopMonitoring(for: region)
            }
        }
    }
    
    func stopMonitoringAllRegionsExceptRegionWithIdentifier(identifier: String) {
        
        for region in self.systemLocationManager.monitoredRegions {
            if region.identifier != identifier {
                self.systemLocationManager.stopMonitoring(for: region)
            }
        }
    }
    
    func stopMonitoringAllRegions() {
        
        for region in self.systemLocationManager.monitoredRegions {
            self.systemLocationManager.stopMonitoring(for: region)
        }
    }
    
    // Requesting state for monitored regions
    func requestStateForMonitoredRegions() {
        for region in self.systemLocationManager.monitoredRegions {
            self.systemLocationManager.requestState(for: region)
        }
    }
    
    func isLocationEnabled() -> (Bool) {
        if CLLocationManager.authorizationStatus() != .denied {
            return true
        }
        return false
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        if region is CLBeaconRegion {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        if region is CLBeaconRegion {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        if region is CLBeaconRegion {
            return
        }
        
        if state == .inside {
            
            let loc = manager.location
            var coord = CLLocationCoordinate2D()
            
            if let aLoc = loc {
                coord.longitude = aLoc.coordinate.longitude
                coord.latitude = aLoc.coordinate.latitude
            }
            
            let strLatLong = "\(coord.latitude) \(coord.longitude)"
            
            //MARK: Need To Implement when carshlog finished
            // [[ApplicationManager sharedInstance].crashAndReportsLogManager reportLocationEventToServerWithType:@"geofence" andSubParam:strLatLong extraInfo:nil];
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        if region is CLBeaconRegion {
            return
        }
        
        let loc = manager.location
        var coord = CLLocationCoordinate2D()
        
        if let aLoc = loc {
            coord.longitude = aLoc.coordinate.longitude
            coord.latitude = aLoc.coordinate.latitude
        }
        
        let strLatLong = "\(coord.latitude) \(coord.longitude)"
        
        var dict = [String:Any]()
        dict.updateValue("insert", forKey: "mode")
        
        //MARK: Need To Implement when carshlog finished
        //  [[ApplicationManager sharedInstance].crashAndReportsLogManager reportLocationEventToServerWithType:@"geofence" andSubParam:strLatLongString extraInfo:dict];
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        if region is CLBeaconRegion {
            return
        }
        
        let loc = manager.location
        var coord = CLLocationCoordinate2D()
        
        if let aLoc = loc {
            coord.longitude = aLoc.coordinate.longitude
            coord.latitude = aLoc.coordinate.latitude
        }
        
        let strLatLong = "\(coord.latitude) \(coord.longitude)"
        
        var dict = [String:Any]()
        dict.updateValue("exit", forKey: "mode")
        
        //MARK: Need To Implement when carshlog finished
        //  [[ApplicationManager sharedInstance].crashAndReportsLogManager reportLocationEventToServerWithType:@"geofence" andSubParam:strLatLongString extraInfo:dict];
        
        for region in self.systemLocationManager.monitoredRegions {
            self.systemLocationManager.stopMonitoring(for: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        if let aNewLocation = newLocation {
            
            if aNewLocation != self.currentLocation {
                
                self.currentLocation = aNewLocation
                
                self.updateUpdateablesWithLocation(newLocation: aNewLocation)
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    
    //MARK: LocationUpdateableProtocol
    func didGetNewLocation(location: CLLocation) {
        
    }
    
    override func reset() {
        LocationManager.sharedInstance = LocationManager()
    }
     
}
