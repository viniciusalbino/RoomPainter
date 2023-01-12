//
//  SignUpInteractor.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation
import AuthenticationServices
import UIKit
import FirebaseAuth

final class SignUpInteractor: NSObject, ASAuthorizationControllerDelegate {
    // MARK: - Viper properties
    weak var output: SignUpInteractorOutputProtocol?
}

// MARK: - Input Protocol

extension SignUpInteractor: SignUpInteractorInputProtocol {
    
    // MARK: - Apple Authorization Methods
    
    func requestAppleLogin(request: ASAuthorizationAppleIDRequest, presentationContextProvider: SignUpPresenterOutputProtocol) {
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = presentationContextProvider
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        output?.finishedAppleAuthorizationSuccess(authorization: authorization)
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        output?.finishedAuthorizationError(error: error)
    }
    
    // MARK: - Firebase Authorization Methods
    func requestFirebaseAuthentication(idToken: String, rawNonce: String, user: User) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idToken,
                                                  rawNonce: rawNonce)
        
        
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            if let error = error {
                self?.output?.finishedAuthorizationError(error: error)
            } else {
                self?.output?.finishedFirebaseAuthorizationSuccess(user: user)
            }
        }
    }
}
