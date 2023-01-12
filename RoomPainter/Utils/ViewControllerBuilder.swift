//
//  ControllerBuilder.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import UIKit
protocol ViewControllerBuilder: AnyObject {
    func build() -> UIViewController
}
