//
//  Spacing.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation

public enum Spacing: String {
    case xxs
    case xs
    case sm
    case md
    case lg
    case xl
    case xxl
    case none
    
    fileprivate var value: Spacing {
        return .init(rawValue: self.rawValue) ?? .none
    }
}

public struct DSSpacing {
    public var spacingValue: CGFloat = 12
    public var enumValue: FontSize = .md
    
    init() {
    }
    
    init(name: String, value: String) {
        enumValue = FontSize(rawValue: name) ?? .xs
        let formatter = NumberFormatter.usNumberFormatter()
        guard let number = formatter.number(from: value) else {
            spacingValue = 12
            return
        }
        spacingValue = CGFloat(truncating: number)
    }
}

public extension CGFloat {
    static func spacing(_ spacing: Spacing) -> CGFloat {
        return TokenManager.shared.getSpacingFor(name: spacing).spacingValue
    }
}
