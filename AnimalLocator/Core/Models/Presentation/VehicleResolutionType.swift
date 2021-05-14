//
//  VehicleResolutionType.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

enum VehicleResolutionType {

    case claimed
    case notFound
    case other
    case unknown(String)

    init?(type: String) {

        switch type {
        case "CLAIMED":
            self = .claimed
        case "NOT_FOUND":
            self = .notFound
        case "OTHER":
            self = .other
        default:
            return nil
        }
    }
}
