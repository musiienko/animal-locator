//
//  LocationManager.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import CoreLocation

enum LocationAuthorizationError: Error {

    case locationServicesDisabled
    case notAuthorized
}

protocol LocationManaging: DefaultManaging {

    var lastCoordinate: Coordinate? { get }

    var didStartHandler: VoidHandler? { get set }
    var didStopHandler: VoidHandler? { get set }
    var didFailToStartHandler: Handler<LocationAuthorizationError>? { get set }
    var didUpdateUserLocationHandler: Handler<Coordinate>? { get set }
}

// TODO: - Wrap CLLocationManager in a separate class, introduce a protocol for it and inject here
final class LocationManager: NSObject, LocationManaging {

    // MARK: - Public properties

    var lastCoordinate: Coordinate? { self.lastLocation?.coordinate }

    var didStartHandler: VoidHandler?
    var didStopHandler: VoidHandler?
    var didFailToStartHandler: Handler<LocationAuthorizationError>?
    var didUpdateUserLocationHandler: Handler<Coordinate>?

    // MARK: - Private properties

    private let locationManager = CLLocationManager()
    private var lastLocation: CLLocation?

    // MARK: - Init

    override init() {
        super.init()

        self.setup()
    }

    // MARK: - Setup

    private func setup() {

        self.locationManager.activityType = .fitness
        self.locationManager.distanceFilter = 100
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // MARK: - API

    func start() {

        self.reset()

        if type(of: self.locationManager).locationServicesEnabled() {
            self.handleAuthorizationStatus(type(of: self.locationManager).authorizationStatus())
        } else {
            self.didFailToStartHandler?(.locationServicesDisabled)
        }
    }

    func stop() {

        self.reset()
        self.didStopHandler?()
    }

    private func reset() {

        self.locationManager.stopUpdatingLocation()
        self.lastLocation = nil
    }

    // MARK: - Helpers

    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.startUpdatingLocation()
        case .denied, .restricted:
            self.didFailToStartDueToAuthorizationStatus()
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("Handle any other possible future case")
        }

        self.locationManager.delegate = self
    }

    private func startUpdatingLocation() {

        self.locationManager.startUpdatingLocation()
        self.didStartHandler?()
    }

    private func didFailToStartDueToAuthorizationStatus() {

        self.locationManager.stopUpdatingLocation()
        self.didFailToStartHandler?(.notAuthorized)
    }

    private func didUpdateUserLocation(_ newLocation: CLLocation) {

        let shouldNotify = self.lastLocation.map { newLocation.distance(from: $0) >= self.locationManager.distanceFilter } ?? true

        if shouldNotify {
            self.didUpdateUserLocationHandler?(newLocation.coordinate)
        }

        self.lastLocation = newLocation
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.handleAuthorizationStatus(status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let newLocation = locations.last {
            self.didUpdateUserLocation(newLocation)
        }
    }
}
