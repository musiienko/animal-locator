//
//  VehicleState.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

enum VehicleState {

    case active
    case damaged
    case gpsIssue
    case lastSearch
    case lost
    case lowBattery
    case maintenance
    case missing
    case outOfOrder

    var description: String {

        switch self {
        case .active:
            return Localizable.active
        case .damaged:
            return Localizable.damaged
        case .gpsIssue:
            return Localizable.gpsIssue
        case .lastSearch:
            return Localizable.lastSearch
        case .lost:
            return Localizable.lost
        case .lowBattery:
            return Localizable.lowBattery
        case .maintenance:
            return Localizable.maintenance
        case .missing:
            return Localizable.missing
        case .outOfOrder:
            return Localizable.outOfOrder
        }
    }

    init?(state: String) {

        switch state {
        case "ACTIVE":
            self = .active
        case "DAMAGED":
            self = .damaged
        case "GPS_ISSUE":
            self = .gpsIssue
        case "LAST_SEARCH":
            self = .lastSearch
        case "LOST":
            self = .lost
        case "LOW_BATTERY":
            self = .lowBattery
        case "MAINTENANCE":
            self = .maintenance
        case "MISSING":
            self = .missing
        case "OUT_OF_ORDER":
            self = .outOfOrder
        default:

            print("Invalid Vehicle State", state)
            return nil
        }
    }
}
