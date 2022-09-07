//
//  SignInAppleModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import AuthenticationServices


class SignInAppleModel {
    
    func onRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func onCompletion(_ result: Result<ASAuthorization, Error>, signedInUser: SignedInUserModel) {
        switch result {
        case .success (let authResults):
            guard let credential = authResults.credential
                    as? ASAuthorizationAppleIDCredential
            else { return }
            
            Task.init {
                do {
                    if let _ = credential.email, let _ = credential.fullName {
                        try await registerNewAccount(credential: credential, signedInUser: signedInUser)
                    } else {
                        try await signInWithExistingAccount(credential: credential, signedInUser: signedInUser)
                    }
                } catch {
                    // handle error
                }
            }
        case .failure (let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
    
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential, signedInUser: SignedInUserModel) async throws {
        
        var user = UserModel(
            uid: credential.user,
            username: usernameSettings.getDefaultUsername(),
            email: credential.email ?? "email N/A",
            firstName: credential.fullName?.givenName ?? "name N/A",
            lastName: credential.fullName?.familyName ?? "lastname N/A"
        )
        do {
            user = try await userDB.addUser(user: user)
            updateSignedInUser(user: user, signedInUser: signedInUser)
        } catch let err {
            throw err
        }
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential, signedInUser: SignedInUserModel) async throws {
        
        do {
            let user = try await userDB.queryUser(withKey: UserModelKeys.uid, .equal, to: credential.user)
            updateSignedInUser(user: user, signedInUser: signedInUser)
        } catch let err {
            throw err
        }
    }
    
    private func updateSignedInUser(user: UserModel, signedInUser: SignedInUserModel) {
        userCD.clearCDEntity()
        userCD.addUser(with: user.uid)
        DispatchQueue.main.async {
            signedInUser.user = user
            signedInUser.status = .signedIn
        }
    }
    
    func signOut(signedInUser: SignedInUserModel) {
        userCD.clearCDEntity()
        DispatchQueue.main.async {
            signedInUser.user = UserModel()
            signedInUser.status = .notSignedIn
        }
    }
}
