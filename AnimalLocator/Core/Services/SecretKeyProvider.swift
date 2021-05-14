//
//  SecretKeyProvider.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 14.05.21.
//

import Foundation

protocol SecretKeyProviding {

    var secretKey: String { get }
}

struct SecretKeyProvider: SecretKeyProviding {

    var secretKey: String {
        fatalError("Provide a secret key")
    }
}
