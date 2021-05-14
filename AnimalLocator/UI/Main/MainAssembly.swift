//
//  MainAssembly.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 14.05.21.
//

import UIKit

enum MainAssembly {

    static func makeViewController() -> UIViewController {

        let locationManager = LocationManager()

        let vehicleService = VehicleAPIService(
            networkService: NetworkService(session: URLSession.shared),
            requestMaker: VehicleRequestMaker(keyProvider: SecretKeyProvider()),
            decoder: JSONDecoder.response
        )

        let vehicleManager = VehicleManager(
            apiService: vehicleService,
            responseScheduler: DispatchQueue.main,
            mapper: VehicleMapper()
        )

        let controller = MainController(
            locationManager: locationManager,
            vehicleManager: vehicleManager,
            networkManager: NetworkReachabilityManager()
        )

        return MainViewController(controller: controller, mapManager: MapManager())
    }
}
