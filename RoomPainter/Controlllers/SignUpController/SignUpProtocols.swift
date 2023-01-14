//
//  SignUpProtocols.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation
import AuthenticationServices

// MARK: - ViewController
protocol SignUpPresenterOutputProtocol: AnyObject, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor
    func finishedLogin(success: Bool)
}

// MARK: - Presenter
protocol SignUpPresenterInputProtocol: AnyObject {
    func requestAppleAuthorization()
}

// MARK: - Interactor
protocol SignUpInteractorInputProtocol: AnyObject {
    func requestAppleLogin(request: ASAuthorizationAppleIDRequest, presentationContextProvider: SignUpPresenterOutputProtocol)
    func requestFirebaseAuthentication(idToken: String, rawNonce: String, user: User)
}

protocol SignUpInteractorOutputProtocol: AnyObject {
    func finishedAppleAuthorizationSuccess(authorization: ASAuthorization)
    func finishedAuthorizationError(error: Error)
    func finishedFirebaseAuthorizationSuccess(user: User)
}

// MARK: - Router
protocol SignUpRouterProtocol: AnyObject {
    
}
