//
//  NumberFormatter+Extensions.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation

public extension NumberFormatter {
    static func usNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
}
