//
//  UserStorage.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 13/01/23.
//

import Foundation
import AuthenticationServices

class UserStorage {
    let keyChain = KeychainItem(service: Bundle.main.bundleIdentifier ?? "", account: "userIdentifier")
    
    public func saveUser(user: User) -> Bool {
        do {
            try keyChain.saveItem(user.user)
            return true
        } catch {
            print("Unable to save userIdentifier to keychain.")
            return false
        }
    }
    
    public func currentUserIdentifier() -> String? {
        do {
            let userIdentifier = try keyChain.readItem()
            return userIdentifier
        } catch {
            return nil
        }
    }
    
    public func deleteUserIdentifierFromKeychain() -> Bool {
        return keyChain.deleteItem()
    }
    
    func checkLoggedUser() async -> Bool {
        guard let userIdentifier = currentUserIdentifier() else {
            return false
        }
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        do {
            let credentialState1 = try await appleIDProvider.credentialState(forUserID: userIdentifier)
            switch credentialState1 {
            case .authorized:
                return true
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                return false
            default:
                return false
            }
        } catch {
            return false
        }
    }
}
