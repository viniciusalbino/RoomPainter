//
//  User.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
import AuthenticationServices
import UIKit

struct User: Mappable {
    var user: String
    var password: String?
    var email: String?
    var fullName: String?
    
    func checkLoggedUser( completionHandler: @escaping(_ userFound: Bool) -> Void) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: user) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                completionHandler(true)
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                completionHandler(false)
            default:
                completionHandler(false)
            }
        }
    }
}
