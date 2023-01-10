//
//  SignUpInteractor.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation

final class SignUpInteractor {
    // MARK: - Viper properties
    weak var output: SignUpInteractorOutputProtocol?
}

// MARK: - Input Protocol

extension SignUpInteractor: SignUpInteractorInputProtocol {
    
}
