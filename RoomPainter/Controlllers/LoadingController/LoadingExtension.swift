//
//  LoadingExtension.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 14/01/23.
//

import Foundation
import UIKit

extension UIViewController {
    public func startLoading() {
        if let currentWindow = UIApplication.shared.currentWindow {
            let loadingBackground = LoadingView(frame: .zero)
            currentWindow.addSubview(loadingBackground)
            currentWindow.isUserInteractionEnabled = false
            loadingBackground.startLoading()
        }
    }
    
    public func stopLoading() {
        // swiftlint:disable closure_spacing
        performUIUpdate {
            if let currentWindow = UIApplication.shared.currentWindow {
                currentWindow.window?.subviews.filter{ $0 is LoadingView }.forEach{ $0.removeFromSuperview() }
                currentWindow.isUserInteractionEnabled = true
            }
        }
        // swiftlint:enable closure_spacing
    }
}
