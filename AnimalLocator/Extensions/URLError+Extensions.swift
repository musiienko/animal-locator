//
//  URLError+Extensions.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

extension URLError {

    static var connectionErrorCodes: [URLError.Code] {

        [
            .timedOut,
            .cannotFindHost,
            .cannotConnectToHost,
            .networkConnectionLost,
            .notConnectedToInternet
        ]
    }

    var isConnectionError: Bool {
        URLError.connectionErrorCodes.contains(self.code)
    }
}
