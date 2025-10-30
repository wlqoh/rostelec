////
////  LocationManager.swift
////  PolevoiInjener
////
////  Created by Мурад on 30/10/25.
////
//
//import SwiftUI
//import MapKit
//import CoreLocation
//import Combine
//
//final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    
//    @Published var authorizationStatus: CLAuthorizationStatus
//    @Published var lastLocation: CLLocation?
//    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423), // Moscow by default
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        )
//    
//    private let manager = CLLocationManager()
//    private let geocoder = CLGeocoder()
//
//        override init() {
//            self.authorizationStatus = manager.authorizationStatus
//            super.init()
//            manager.delegate = self
//            manager.desiredAccuracy = kCLLocationAccuracyBest
//            manager.distanceFilter = 5 // meters
//        }
//    
//    func requestPermission() {
//        // Выбирай нужный метод в зависимости от сценария:
//        manager.requestWhenInUseAuthorization()
//        // manager.requestAlwaysAuthorization() // если нужен всегда
//    }
//
//    func startUpdating() {
//        guard CLLocationManager.locationServicesEnabled() else { return }
//        manager.startUpdatingLocation()
//    }
//
//    func stopUpdating() {
//        manager.stopUpdatingLocation()
//    }
//    
//}
