//
//  LocationManager.swift
//  FinalProject
//
//  Created by tu.le2 on 04/09/2022.
//

import Foundation
import CoreLocation

typealias LocationCompletion = (CLLocation) -> Void

final class LocationManager: NSObject {

    private static var sharedLocationManager: LocationManager = {
        let locationManager = LocationManager()
        return locationManager
    }()

    class func shared() -> LocationManager {
        return sharedLocationManager
    }

    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var currentCompletion: LocationCompletion?
    private var locationCompletion: LocationCompletion?
    private var isUpdatingLocation = false

    override init() {
        super.init()
        configLocationManager()
    }

    func configLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.allowsBackgroundLocationUpdates = true
    }

    func request() {
        let status = CLLocationManager.authorizationStatus()
        if !CLLocationManager.locationServicesEnabled() {
            return
        } else {
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                break
            case .denied:
                break
            case .authorizedAlways:
                break
            case .authorizedWhenInUse:
                break
            case .authorized:
                break
            @unknown default:
                break
            }
            locationManager.requestLocation()
        }
    }

    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }

    func getCurrentLocation(completion: @escaping LocationCompletion) {
        currentCompletion = completion
        locationManager.requestLocation()
    }

    func startUpdating(completion: @escaping LocationCompletion) {
        locationCompletion = completion
        isUpdatingLocation = true
        locationManager.startUpdatingLocation()
    }

    func stopUpdating() {
        locationManager.stopUpdatingLocation()
        isUpdatingLocation = false
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        default:
            print("default")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            if let current = currentCompletion {
                current(location)
            }
            if isUpdatingLocation, let updating = locationCompletion {
                updating(location)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
