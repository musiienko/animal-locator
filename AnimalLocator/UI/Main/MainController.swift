//
//  MainController.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

final class MainController: MainControllerProtocol {

    // MARK: - Public properties

    weak var view: MainViewInput?

    // MARK: - Private properties

    private let locationManager: LocationManaging
    private let vehicleManager: VehicleManaging
    private let networkManager: NetworkReachabilityManaging

    private var didLoadDataOnce = false
    private var isLoading = false {
        didSet {
            self.view?.handleLoading(isFinished: !self.isLoading)
        }
    }

    // MARK: - Init

    init(
        locationManager: LocationManaging,
        vehicleManager: VehicleManaging,
        networkManager: NetworkReachabilityManaging
    ) {

        self.locationManager = locationManager
        self.vehicleManager = vehicleManager
        self.networkManager = networkManager

        self.setupLocationManager()
        self.setupNetworkManager()
    }

    // MARK: - API

    private func setupLocationManager() {

        self.locationManager.didStartHandler = { [weak self] in
            self?.view?.handleLocationTrackingStart()
        }

        self.locationManager.didStopHandler = { [weak self] in
            self?.view?.handleLocationTrackingStop()
        }

        self.locationManager.didFailToStartHandler = { [weak self] error in
            self?.view?.handleError(error: .location(error))
        }

        self.locationManager.didUpdateUserLocationHandler = { [weak self] location in

            guard let self = self else {
                return
            }

            if self.didLoadDataOnce {
                return
            }

            self.didLoadDataOnce = true
            self.loadData(for: location)
        }
    }

    private func setupNetworkManager() {

        self.networkManager.didUpdateIsConnectedStateHandler = { [weak self] isConnected in

            if !isConnected {
                self?.view?.handleError(error: .data(.connectionError))
            }
        }
    }

    func start() {

        self.locationManager.start()
        self.networkManager.start()
    }

    func reload() {

        if let location = self.locationManager.lastCoordinate {
            self.loadData(for: location)
        } else {
            self.start()
        }
    }

    func loadData(for userLocation: Coordinate) {

        if self.isLoading {
            return
        }

        self.isLoading = true

        self.vehicleManager.getVehiclesData(for: userLocation) { [weak self] result in
            self?.handleResult(result)
        }
    }

    private func handleResult(_ result: Result<VehicleInfoModel, VehicleError>) {

        self.isLoading = false

        switch result {
        case .success(let model):
            self.view?.handleSuccess(model: model)
        case .failure(let error):
            self.view?.handleError(error: .data(error))
        }
    }
}
