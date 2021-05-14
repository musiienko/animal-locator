//
//  NetworkReachabilityManager.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import Network

protocol NetworkReachabilityManaging: DefaultManaging {

    var didUpdateIsConnectedStateHandler: Handler<Bool>? { get set }
}

// TODO: - Wrap NWPathMonitor in a separate class, introduce a protocol for it and inject here
final class NetworkReachabilityManager: NetworkReachabilityManaging {

    // MARK: - Public properties

    var didUpdateIsConnectedStateHandler: Handler<Bool>?

    // MARK: - Private properties

    private var monitor: NWPathMonitor!

    // MARK: - API

    func start() {

        self.stop()

        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { [weak self] path in
            self?.didUpdateIsConnectedStateHandler?(path.status == .satisfied)
        }

        monitor.start(queue: .main)
        self.monitor = monitor
    }

    func stop() {

        self.monitor?.cancel()
        self.monitor = nil
    }
}
