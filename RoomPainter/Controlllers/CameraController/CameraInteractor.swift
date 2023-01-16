//
//  CameraInteractor.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 16/01/23.
//

import Foundation
import UIKit

class CameraInteractor {
    // MARK: - Viper properties
    weak var output: CameraInteractorOutputProtocol?
}

// MARK: - Input Protocol

extension CameraInteractor: CameraInteractorInputProtocol {
    
}
