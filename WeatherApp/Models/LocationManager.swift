//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Engy on 8/25/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var locationUpdateCompletion: ((CLLocation) -> Void) = {_ in}
    @Published var currentLocation: CLLocation? {
        didSet {
            if let currentLocation = currentLocation {
                locationUpdateCompletion(currentLocation)
            }
        }
    }

    override init() {
        super.init()
        locationManager.delegate = self

    }
     func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
         locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let cleError = error as? CLError else {
            print("Unknown location error: \(error.localizedDescription)")
            return
        }

        switch cleError.code {
        case .denied:
            print("User denied location services.")
        default:
            print("Location error: \(cleError.localizedDescription)")
        }
    }

}
