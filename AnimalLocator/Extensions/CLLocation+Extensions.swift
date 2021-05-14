//
//  CLLocation+Extensions.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import CoreLocation

extension CLLocation {

    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        self.distance(from: .init(coordinate: coordinate))
    }

    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
