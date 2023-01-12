//
//  UIColor+Extensions.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    public convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let sanitizedString = hexString
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "#", with: "")
        
        var RGB = UInt32(0)
        Scanner(string: sanitizedString).scanHexInt32(&RGB)
        self.init(netHex: RGB, alpha: alpha)
    }
    
    public convenience init(red: UInt32, green: UInt32, blue: UInt32, alphaValue: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaValue)
    }
    
    public convenience init(netHex: UInt32, alpha: CGFloat = 1.0) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff, alphaValue: alpha)
    }
    
    public func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red * 255)<<16 | (Int)(green * 255)<<8 | (Int)(blue * 255)<<0
        return String(format: "#%06x", rgb)
    }
}
