//
//  SignUpPresenter.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation
import AuthenticationServices
import FirebaseAuth

final class SignUpPresenter {
    // MARK: -  Viper Properties
    
    weak var viewController: SignUpPresenterOutputProtocol?
    private let router: SignUpRouterProtocol
    private let interactor: SignUpInteractorInputProtocol
    
    // MARK: - Private variables
    private var currentNonce = ""
    
    // MARK: - init
    init(router: SignUpRouterProtocol, interactor: SignUpInteractorInputProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Private methods
    private func logUser(user: User) {
        let userStorate = UserStorage()
        if userStorate.saveUser(user: user) {
            viewController?.finishedLogin(success: true)
        } else {
            viewController?.finishedLogin(success: false)
        }
    }
}

// MARK: - Presenter Input Protocol
extension SignUpPresenter: SignUpPresenterInputProtocol {
    func requestAppleAuthorization() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        currentNonce = randomNonceString()
        request.nonce = sha256(currentNonce)
        interactor.requestAppleLogin(request: request, presentationContextProvider: viewController!)
    }
}

// MARK: - Presenter Output Protocol
extension SignUpPresenter: SignUpInteractorOutputProtocol {    
    func finishedAppleAuthorizationSuccess(authorization: ASAuthorization) {
        switch authorization.credential {
            //Create a new account
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fech identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialze token string from data")
                return
            }
            
            var user = User(user: appleIDCredential.user,
                            email: appleIDCredential.email,
                            fullName: appleIDCredential.fullName?.formatted())
            interactor.requestFirebaseAuthentication(idToken: idTokenString, rawNonce: currentNonce, user: user)
            // Sign in using an existing iCloud Keychain
        case let passwordCredential as ASPasswordCredential:
            var user = User(user: passwordCredential.user,
                            password: passwordCredential.password)
            logUser(user: user)
        default:
            break
        }
    }
    
    func finishedAuthorizationError(error: Error) {
        print(error)
    }
    
    func finishedFirebaseAuthorizationSuccess(user: User) {
        logUser(user: user)
    }
}
