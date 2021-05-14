//
//  URLSession+NetworkSession.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

extension URLSession: NetworkSession {

    @discardableResult
    func performTask(with request: URLRequest, completion: ResultHandler<(Data, URLResponse?), Error>?) -> Cancellable {

        let task = self.dataTask(with: request) { data, response, error in

            let result: Result<(Data, URLResponse?), Error>

            if let error = error {
                result = .failure(error)
            } else {
                result = data.map { .success(($0, response)) } ?? .failure(UnknownError())
            }

            completion?(result)
        }

        task.resume()
        return task
    }
}
