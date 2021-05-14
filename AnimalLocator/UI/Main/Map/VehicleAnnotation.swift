//
//  VehicleAnnotation.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import MapKit

final class VehicleAnnotation: NSObject, MKAnnotation {

    // MARK: - Public properties

    let vehicle: VehicleModel

    var title: String? { self.vehicle.vehicleId }
    var coordinate: CLLocationCoordinate2D { self.vehicle.coordinate }

    // MARK: - Init

    init(vehicle: VehicleModel) {
        self.vehicle = vehicle

        super.init()
    }
}
