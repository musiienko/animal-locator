//
//  MainViewController.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import MapKit
import UIKit

enum MainViewError: Error {

    case location(LocationAuthorizationError)
    case data(VehicleError)
}

final class MainViewController: UIViewController {

    // MARK: - Views

    private lazy var loadingIndicatorView: UIView = {

        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()

    private lazy var reloadBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.reload))

    // MARK: - Private properties

    private let controller: MainControllerProtocol
    private let mapManager: MapManaging

    // MARK: - Init

    init(controller: MainControllerProtocol, mapManager: MapManaging) {

        self.controller = controller
        self.mapManager = mapManager

        super.init(nibName: nil, bundle: nil)

        self.controller.view = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private let mapView = MKMapView()

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapManager.setup(with: self.mapView)
        self.controller.start()
    }

    // MARK: - Actions

    @objc private func reload() {
        self.controller.reload()
    }

    private func showLoadingIndicator(show: Bool) {
        self.navigationItem.leftBarButtonItem = show ? .init(customView: self.loadingIndicatorView) : nil
    }

    private func showReloadItem(show: Bool) {
        self.navigationItem.rightBarButtonItem = show ? self.reloadBarButtonItem : nil
    }

    private func presentAlert(for error: Error) {

        let alert = UIAlertController(
            title: Localizable.error,
            message: Localizable.errorMessage("\(error)"), preferredStyle: .alert)
        alert.addAction(.init(title: Localizable.ok, style: .default))
        self.present(alert, animated: true)
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {

    func handleLocationTrackingStart() {
        self.showReloadItem(show: true)
    }

    func handleLocationTrackingStop() {
        self.showReloadItem(show: false)
    }

    func handleLoading(isFinished: Bool) {

        self.showLoadingIndicator(show: !isFinished)
        self.reloadBarButtonItem.isEnabled = isFinished
    }

    func handleSuccess(model: VehicleInfoModel) {
        self.mapManager.configure(with: model.vehicles)
    }

    func handleError(error: MainViewError) {
        self.presentAlert(for: error)
    }
}
