//
//  MapManager.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import MapKit

protocol MapManaging: AnyObject {

    func setup(with mapView: MKMapView)
    func configure(with vehicles: [VehicleModel])
}

final class MapManager: NSObject, MapManaging {

    // MARK: - Private properties

    private let reuseId = String(describing: VehicleAnnotationView.self)
    private var isInitialUpdate = true

    private weak var mapView: MKMapView?

    // MARK: - Setup

    func setup(with mapView: MKMapView) {

        self.mapView = mapView

        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        mapView.register(VehicleAnnotationView.self, forAnnotationViewWithReuseIdentifier: self.reuseId)

        self.setDefaultLocation(on: mapView)
    }

    private func setDefaultLocation(on mapView: MKMapView) {

        let center = Coordinate(latitude: 52.506282329714104, longitude: 13.373136712291933)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)

        mapView.setRegion(region, animated: true)
    }

    // MARK: - Configure

    func configure(with vehicles: [VehicleModel]) {

        defer {
            self.isInitialUpdate = true
        }

        guard let mapView = self.mapView else {
            return
        }

        mapView.removeAnnotations(mapView.annotations)

        let annotations = vehicles.map(VehicleAnnotation.init(vehicle:))
        mapView.addAnnotations(annotations)

        let rentableAnnotations = annotations.filter(\.vehicle.canBeRented)
        let userAnnotation = mapView.userLocation

        if rentableAnnotations.isEmpty {

            mapView.showAnnotations(annotations + [userAnnotation], animated: true)
            return
        }

        guard let userLocation = mapView.userLocation.location else {

            mapView.showAnnotations(rentableAnnotations + [userAnnotation], animated: true)
            return
        }

        // safe to unwrap since we have a check for rentable annotations above
        let closestAnnotation = rentableAnnotations.min {
            userLocation.distance(from: $0.coordinate) < userLocation.distance(from: $1.coordinate)
        }!

        mapView.showAnnotations([closestAnnotation, mapView.userLocation], animated: true)

        if self.isInitialUpdate {
            mapView.selectAnnotation(closestAnnotation, animated: true)
        }
    }
}

// MARK: - MKMapViewDelegate

extension MapManager: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if let annotation = annotation as? VehicleAnnotation {
            return mapView.dequeueReusableAnnotationView(withIdentifier: self.reuseId, for: annotation)
        } else { // clustering
            return nil
        }
    }
}
