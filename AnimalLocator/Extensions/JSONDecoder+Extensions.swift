//
//  JSONDecoder+Extensions.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

extension JSONDecoder: ModelDecoding { }

extension JSONDecoder {

    static let response: JSONDecoder = {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
