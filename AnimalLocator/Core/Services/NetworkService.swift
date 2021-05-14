//
//  NetworkService.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

protocol NetworkServiceProviding {

    func performRequest(_ request: URLRequest, completion: @escaping ResultHandler<Data, URLError>)
}

final class NetworkService: NetworkServiceProviding {

    // MARK: - Private properties

    private let session: NetworkSession

    // MARK: - Init

    init(session: NetworkSession) {
        self.session = session
    }

    // MARK: - API

    func performRequest(_ request: URLRequest, completion: @escaping ResultHandler<Data, URLError>) {

        self.session.performTask(with: request) { result in
            completion(result.map(\.0).mapError { URLError(.init(rawValue: ($0 as NSError).code)) })
        }
    }
}
