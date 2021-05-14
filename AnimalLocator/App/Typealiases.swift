//
//  Typealiases.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D
typealias VoidHandler = () -> Void
typealias Handler<T> = (T) -> Void
typealias ResultHandler<T, E: Error> = Handler<Result<T, E>>
