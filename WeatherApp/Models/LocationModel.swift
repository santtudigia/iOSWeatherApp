//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 12.10.2021.
//

import Foundation
import CoreLocation

class LocationModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var status : CLAuthorizationStatus = .notDetermined
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    public func startUpdatingLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
    }
}
