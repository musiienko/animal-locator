//
//  NetworkSession.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

struct UnknownError: Error { }

protocol NetworkSession {

    @discardableResult
    func performTask(with request: URLRequest, completion: ResultHandler<(Data, URLResponse?), Error>?) -> Cancellable
}
