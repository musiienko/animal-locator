//
//  VehicleRequestMaker.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

protocol VehicleRequestMaking {

    func makeRequest(userCoordinate: Coordinate) -> URLRequest?
}

struct VehicleRequestMaker: VehicleRequestMaking {

    // MARK: - Private properties

    private let keyProvider: SecretKeyProviding

    // MARK: - Init

    init(keyProvider: SecretKeyProviding) {
        self.keyProvider = keyProvider
    }

    // MARK: - API

    func makeRequest(userCoordinate: Coordinate) -> URLRequest? {

        guard let components = URLComponents(url: Constants.API.requestURL, resolvingAgainstBaseURL: false) else {
            return nil
        }

        // let's imagine for a moment that we are using a real API, not jsonbin ;)
        // uncomment to add the user coordinate to the query
//        components.queryItems = [
//            .init(name: "lat", value: "\(userCoordinate.latitude)"),
//            .init(name: "lon", value: "\(userCoordinate.longitude)")
//        ]

        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)

        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.keyProvider.secretKey, forHTTPHeaderField: "secret-key")

        return request
    }
}
