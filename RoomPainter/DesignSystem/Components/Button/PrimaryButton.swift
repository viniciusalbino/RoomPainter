//
//  PrimaryButton.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 16/01/23.
//

import Foundation
import UIKit

class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration = buttonConfiguration
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuration = buttonConfiguration
    }
    
    var buttonConfiguration: UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .designSystem(.textPrimaryColor)
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = .designSystem(.primaryColor)
        return configuration
    }
}
