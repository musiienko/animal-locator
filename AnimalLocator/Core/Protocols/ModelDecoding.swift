//
//  ModelDecoding.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

protocol ModelDecoding {

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}
