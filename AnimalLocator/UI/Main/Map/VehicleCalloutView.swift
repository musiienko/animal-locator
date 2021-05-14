//
//  VehicleCalloutView.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import UIKit

final class VehicleCalloutView: UIView {

    // MARK: - Public properties

    override var intrinsicContentSize: CGSize {
        self.stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    // MARK: - Views

    private let stackView = UIStackView()

    // MARK: - Init

    convenience init(model: VehicleModel) {
        self.init(frame: .zero)

        self.configure(with: model)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupStackView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func layoutSubviews() {
        super.layoutSubviews()

        self.stackView.frame = self.bounds
    }

    // MARK: - Setup

    private func setupStackView() {

        self.addSubview(self.stackView)

        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.alignment = .fill
        self.stackView.spacing = 0
    }

    // MARK: - Configure

    func configure(with model: VehicleModel) {

        let texts: [(String, String)] = [
            (Localizable.state, model.state.description),
            (Localizable.chargeLevel, Localizable.numberOfPercent(model.batteryLevel)),
            (Localizable.model, model.model)
        ]

        self.stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        let views: [UIView] = texts.map {

            let textLabel = UILabel()
            textLabel.font = .preferredFont(forTextStyle: .caption2)
            textLabel.text = Localizable.deviceInfo(title: $0.0, detail: $0.1)
            return textLabel
        }

        views.forEach(self.stackView.addArrangedSubview(_:))
    }
}
