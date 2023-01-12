//
//  TabBarItem.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import UIKit

enum TabBarItem: Int {
    case scan = 0
    case profile = 1
    
    var title: String {
        switch self {
        case .scan:
            return "Escanear".localized()
        case .profile:
            return "Meu perfil".localized()
        }
    }
    
    var icon: UIImage {
        switch self {
        case .scan:
            return UIImage(systemName: "camera.on.rectangle")!
        case .profile:
            return UIImage(systemName: "person")!
        }
    }
    
    var accessibilityIdentifier: String {
        return self.title.uppercased()
    }
}
