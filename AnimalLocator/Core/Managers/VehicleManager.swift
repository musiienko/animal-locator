//
//  VehicleManager.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

enum VehicleError: Error {

    case connectionError
    case other
}

protocol VehicleManaging {

    func getVehiclesData(for userLocation: Coordinate, completion: @escaping ResultHandler<VehicleInfoModel, VehicleError>)
}

final class VehicleManager: VehicleManaging {

    // MARK: - Private properties

    private let apiService: VehicleServiceProviding
    private let responseScheduler: Scheduling
    private let mapper: VehicleMapping

    // MARK: - Init

    init(apiService: VehicleServiceProviding, responseScheduler: Scheduling, mapper: VehicleMapping) {

        self.apiService = apiService
        self.responseScheduler = responseScheduler
        self.mapper = mapper
    }

    // MARK: - API

    func getVehiclesData(for userLocation: Coordinate, completion: @escaping ResultHandler<VehicleInfoModel, VehicleError>) {

        self.apiService.getVehicles(for: userLocation) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }

    private func handleResult(_ result: Result<VehicleAPIResponseModel, VehicleAPIError>, completion: @escaping ResultHandler<VehicleInfoModel, VehicleError>) {

        let result = result
            .map(self.mapper.toPresentationModel(from:))
            .mapError(self.mapper.toPresentationError(from:))

        self.responseScheduler.schedule {
            completion(result)
        }
    }
}
