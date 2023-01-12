//
//  DSFontSize.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation

public enum FontSize: String {
    case xs
    case sm
    case md
    case lg
    case xl
    
    fileprivate var value: FontSize {
        return .init(rawValue: rawValue)!
    }
}

public struct DSFontSize {
    public var fontSize: CGFloat = 12
    public var enumValue: FontSize = .md
    
    init() {
    }
    
    init(name: String, value: String) {
        enumValue = FontSize(rawValue: name) ?? .xs
        let formatter = NumberFormatter.usNumberFormatter()
        guard let number = formatter.number(from: value) else {
            fontSize = 12
            return
        }
        fontSize = CGFloat(truncating: number)
    }
}

public extension CGFloat {
    static func fontSize(_ size: FontSize) -> CGFloat {
        return TokenManager.shared.getFontSizeFor(name: size).fontSize
    }
}
