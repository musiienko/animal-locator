//
//  VehicleModel.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

struct VehicleModel {

    let id: String
    let vehicleId: String
    let zoneId: String
    let resolutionType: VehicleResolutionType?
    let resolvedAt: Date?
    let batteryLevel: Int
    let state: VehicleState
    let model: String
    let coordinate: Coordinate

    var canBeRented: Bool {

        if self.state == .active || self.state == .lowBattery {
            return self.batteryLevel > 0
        } else {
            return false
        }
    }
}
