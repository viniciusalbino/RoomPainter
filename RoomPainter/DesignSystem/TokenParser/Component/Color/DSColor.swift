//
//  Color.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import UIKit

public enum Color: String, CaseIterable, Codable {
    case primaryColor
    case secondaryColor
    case terciaryColor
    
    case none
    case clear
    
    public func color() -> UIColor {
        switch self {
        case .clear, .none:
            return .clear
        default:
            return TokenManager.shared.getColorFor(name: self).color
        }
    }
}

public struct DSColor {
    public var hexString: String = ""
    public var enumValue: Color = .clear
    public var color: UIColor = .clear
    
    init() { }
    
    public init(colorHex: String, value: String) {
        hexString = colorHex
        enumValue = Color(rawValue: value) ?? .clear
        color = UIColor(hex: colorHex)
    }
}

public extension UIColor {
    class func soma(_ colorEnum: Color) -> UIColor {
        return colorEnum.color()
    }
}
