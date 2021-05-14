//
//  VehicleAPIResponseModel.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

struct VehicleAPIResponseModel: Decodable {

    private enum CodingKeys: String, CodingKey {
        case data, current, stats
    }

    // MARK: - Public properties

    let items: [VehicleAPIModel]
    let stats: StatsAPIModel

    // MARK: - Init

    init(from decoder: Decoder) throws {

        let dataContainer = try decoder
            .container(keyedBy: CodingKeys.self)
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        self.items = try dataContainer.decode([VehicleAPIModel].self, forKey: .current)
        self.stats = try dataContainer.decode(StatsAPIModel.self, forKey: .stats)
    }
}
