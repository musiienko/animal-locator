//
//  DispatchQueue+Scheduling.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Foundation

extension DispatchQueue: Scheduling {

    func schedule(block: @escaping VoidHandler) {
        self.async(execute: block)
    }
}
