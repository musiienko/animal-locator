//
//  VehicleAnnotationView.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 13.05.21.
//

import MapKit

final class VehicleAnnotationView: MKAnnotationView {

    // MARK: - Public properties

    override var annotation: MKAnnotation? {
        didSet {
            self.configure()
        }
    }

    // MARK: - Views

    private let colorView = UIView()
    private let label = UILabel()

    // MARK: - Init

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func layoutSubviews() {
        super.layoutSubviews()

        self.label.frame = self.bounds
        self.colorView.frame = self.bounds
        self.colorView.layer.cornerRadius = self.colorView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.configureSelectedState()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.detailCalloutAccessoryView = nil
    }

    // MARK: - Setup

    private func setup() {

        self.clusteringIdentifier = Constants.clusteringIdentifier
        self.canShowCallout = true

        let dimension: CGFloat = 40
        self.frame = .init(origin: .zero, size: .init(width: dimension, height: dimension))

        self.setupSubviews()
    }

    private func setupSubviews() {

        self.addSubview(self.colorView)
        self.addSubview(self.label)

        self.colorView.clipsToBounds = true

        self.label.textColor = .systemBackground
        self.label.font = .preferredFont(forTextStyle: .caption2)
        self.label.textAlignment = .center
        self.label.lineBreakMode = .byTruncatingTail
    }

    // MARK: - Configure

    private func configure() {

        if let annotation = self.annotation as? VehicleAnnotation {
            self.configure(with: annotation)
        }

        self.configureSelectedState()
    }

    private func configureSelectedState() {

        self.colorView.layer.borderWidth = self.isSelected ? 3 : 0
        self.colorView.layer.borderColor = self.isSelected ? UIColor.systemPink.cgColor : nil
    }

    private func configure(with annotation: VehicleAnnotation) {

        self.label.text = Localizable.numberOfPercent(annotation.vehicle.batteryLevel)
        self.colorView.backgroundColor = self.makeBackgroundColor(state: annotation.vehicle.state)
        self.detailCalloutAccessoryView = VehicleCalloutView(model: annotation.vehicle)
    }

    private func makeBackgroundColor(state: VehicleState) -> UIColor {

        switch state {
        case .active:
            return .systemGreen
        case .maintenance:
            return .brown
        case .lastSearch:
            return .systemTeal
        case .lowBattery:
            return .systemYellow
        case .lost, .missing:
            return .systemGray
        case .damaged, .gpsIssue:
            return .systemRed
        case .outOfOrder:
            return .black
        }
    }
}
