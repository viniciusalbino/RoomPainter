//
//  SignUpPresenter.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation

final class SignUpPresenter {
    // MARK: -  Viper Properties
    
    weak var viewController: SignUpPresenterOutputProtocol?
    private let router: SignUpRouterProtocol
    private let interactor: SignUpInteractorInputProtocol
    
    // MARK: - init
    init(router: SignUpRouterProtocol, interactor: SignUpInteractorInputProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Presenter Input Protocol
extension SignUpPresenter: SignUpPresenterInputProtocol {
    
}

// MARK: - Presenter Output Protocol
extension SignUpPresenter: SignUpInteractorOutputProtocol {
    
}
