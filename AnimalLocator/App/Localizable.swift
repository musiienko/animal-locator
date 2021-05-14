//
//  Localizable.swift
//  AnimalLocator
//
//  Created by Maksym Musiienko on 14.05.21.
//

import Foundation

enum Localizable {

    static var active: String { self.makeString(key: "active") }
    static var damaged: String { self.makeString(key: "damaged") }
    static var gpsIssue: String { self.makeString(key: "gps_issue") }
    static var lastSearch: String { self.makeString(key: "last_search") }
    static var lost: String { self.makeString(key: "lost") }
    static var lowBattery: String { self.makeString(key: "low_battery") }
    static var maintenance: String { self.makeString(key: "maintenance") }
    static var missing: String { self.makeString(key: "missing") }
    static var outOfOrder: String { self.makeString(key: "out_of_order") }
    static var error: String { self.makeString(key: "error_title") }
    static var ok: String { self.makeString(key: "ok") }
    static var state: String { self.makeString(key: "state") }
    static var chargeLevel: String { self.makeString(key: "charge_level") }
    static var model: String { self.makeString(key: "model") }

    static func errorMessage(_ content: String) -> String {
        self.makeString(key: "error_message", content)
    }

    static func deviceInfo(title: String, detail: String) -> String {
        self.makeString(key: "device_info_format", title, detail)
    }

    static func numberOfPercent(_ value: Int) -> String {
        self.makeString(key: "number_of_percent", value)
    }

    private static func makeString(key: String, _ arguments: CVarArg...) -> String {

        let format = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        return String(format: format, locale: nil, arguments: arguments)
    }
}
