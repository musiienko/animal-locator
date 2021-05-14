//
//  VehicleMapper.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

protocol VehicleMapping {

    func toPresentationModel(from apiModel: VehicleAPIResponseModel) -> VehicleInfoModel
    func toPresentationError(from apiError: VehicleAPIError) -> VehicleError
}

struct VehicleMapper: VehicleMapping {

    func toPresentationError(from apiError: VehicleAPIError) -> VehicleError {

        switch apiError {
        case .request(let error) where error.isConnectionError:
            return .connectionError
        default:
            return .other
        }
    }

    func toPresentationModel(from apiModel: VehicleAPIResponseModel) -> VehicleInfoModel {

        VehicleInfoModel(
            vehicles: apiModel.items.compactMap(self.toPresentationModel(from:)),
            open: apiModel.stats.open,
            assigned: apiModel.stats.assigned,
            resolved: apiModel.stats.resolved
        )
    }

    private func toPresentationModel(from apiModel: VehicleAPIModel) -> VehicleModel? {

        guard let state = VehicleState(state: apiModel.state) else {
            return nil
        }

        return VehicleModel(
            id: apiModel.id,
            vehicleId: apiModel.vehicleId,
            zoneId: apiModel.zoneId,
            resolutionType: apiModel.resolution.flatMap(VehicleResolutionType.init(type:)),
            resolvedAt: apiModel.resolvedAt,
            batteryLevel: apiModel.battery,
            state: state,
            model: apiModel.model,
            coordinate: .init(latitude: apiModel.latitude, longitude: apiModel.longitude)
        )
    }
}
