//
//  CameraPresenter.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 16/01/23.
//

import Foundation
import UIKit

class CameraPresenter {
    // MARK: -  Viper Properties
    
    weak var viewController: CameraPresenterOutputProtocol?
    private let router: CameraRouterProtocol
    private let interactor: CameraInteractorInputProtocol
    
    // MARK: - Private variables
    
    // MARK: - init
    init(router: CameraRouterProtocol, interactor: CameraInteractorInputProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Presenter Input Protocol
extension CameraPresenter: CameraPresenterInputProtocol {
    
}

// MARK: - Presenter Output Protocol
extension CameraPresenter: CameraInteractorOutputProtocol {
    
}
