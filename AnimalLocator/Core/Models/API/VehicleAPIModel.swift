//
//  VehicleAPIModel.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

struct VehicleAPIModel: Decodable {

    let id: String
    let vehicleId: String
    let zoneId: String
    let resolution: String?
    let resolvedAt: Date?
    let battery: Int
    let state: String
    let model: String
    let fleetbirdId: Int
    let latitude: Double
    let longitude: Double
}

struct StatsAPIModel: Decodable {

    let open: Int
    let assigned: Int
    let resolved: Int
}
