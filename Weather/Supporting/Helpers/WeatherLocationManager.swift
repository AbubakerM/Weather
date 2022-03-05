//  LocationManager
//  LocationManager.swift

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static var shared: LocationManager = LocationManager()
    let locationManager =  CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        askLocationAutorization()
    }
    
    func askLocationAutorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        default: break
        }
    }
    
    internal func getCurrentLocation() -> CLLocationCoordinate2D? {
        if let location = locationManager.location?.coordinate {
            locationManager.stopUpdatingLocation()
            return location
        } else {
            locationManager.startUpdatingLocation()
            return nil
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            askLocationAutorization()
        case .denied:
            //Inform user to enable from settings.
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            NotificationCenter.default.post(
                name: .LocationAuthorizationUpdated,
              object: nil
            )
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.first {
            manager.stopUpdatingLocation()
        }
    }
}
