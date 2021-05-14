//
//  VehicleAPIError.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

enum VehicleAPIError: Error {

    case invalidURL
    case invalidData
    case request(URLError)
}
