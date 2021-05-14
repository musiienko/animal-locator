//
//  Cancellable.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

protocol Cancellable {

    func cancel()
}

extension URLSessionTask: Cancellable { }
