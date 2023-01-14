//
//  UIViewController+Extensions.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 14/01/23.
//

import Foundation
import UIKit

extension UIViewController {
    public func performUIUpdate(using closure: @escaping () -> Void) {
        // If we are already on the main thread, execute the closure directly
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}
