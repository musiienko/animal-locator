//
//  MainProtocols.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

protocol MainViewInput: AnyObject {

    func handleLocationTrackingStart()
    func handleLocationTrackingStop()
    func handleLoading(isFinished: Bool)
    func handleSuccess(model: VehicleInfoModel)
    func handleError(error: MainViewError)
}

protocol MainControllerProtocol: AnyObject {

    var view: MainViewInput? { get set }

    func start()
    func reload()
}
