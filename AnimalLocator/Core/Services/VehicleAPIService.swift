//
//  VehicleAPIService.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

protocol VehicleServiceProviding {

    func getVehicles(for userCoordinate: Coordinate, completion: @escaping ResultHandler<VehicleAPIResponseModel, VehicleAPIError>)
}

final class VehicleAPIService: VehicleServiceProviding {

    // MARK: - Private properties

    private let networkService: NetworkServiceProviding
    private let requestMaker: VehicleRequestMaking
    private let decoder: ModelDecoding

    // MARK: - Init

    init(
        networkService: NetworkServiceProviding,
        requestMaker: VehicleRequestMaking,
        decoder: ModelDecoding
    ) {

        self.networkService = networkService
        self.requestMaker = requestMaker
        self.decoder = decoder
    }

    // MARK: - API

    func getVehicles(for userCoordinate: Coordinate, completion: @escaping ResultHandler<VehicleAPIResponseModel, VehicleAPIError>) {

        guard let request = self.requestMaker.makeRequest(userCoordinate: userCoordinate) else {

            completion(.failure(.invalidURL))
            return
        }

        self.networkService.performRequest(request) { [weak self] result in
            self?.handleVehiclesResult(result, completion: completion)
        }
    }

    private func handleVehiclesResult(_ result: Result<Data, URLError>, completion: ResultHandler<VehicleAPIResponseModel, VehicleAPIError>) {

        let result: Result<VehicleAPIResponseModel, VehicleAPIError> = result.mapError(VehicleAPIError.request).flatMap { data in

            do {
                return .success(try self.decoder.decode(VehicleAPIResponseModel.self, from: data))
            } catch {
                return .failure(.invalidData)
            }
        }
        
        completion(result)
    }
}
