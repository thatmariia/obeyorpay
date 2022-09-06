//
//  SignInAppleModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import AuthenticationServices


class SignInAppleModel {
    
    var parent: SignInView?
    
    init(parent: SignInView) {
        self.parent = parent
    }
    
    
    func onRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func onCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success (let authResults):
            guard let credential = authResults.credential
                    as? ASAuthorizationAppleIDCredential
            else { return }
            
            Task.init {
                do {
                    try await handleCredential(credential: credential)
                } catch {
                    // handle error
                }
            }
            
//            // try signing in
//            signInWithExistingAccount(credential: credential)
//
//            if let _ = credential.email, let _ = credential.fullName {
//                // if can't sign in, sign up
//                if self.parent?.signedInUser.status == .notSignedIn {
//                    registerNewAccount(credential: credential)
//                }
//            } else {
//                // TODO:: remove account? (eg: signed in on the phone but no record in db)
//            }
        case .failure (let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
    
    private func handleCredential(credential: ASAuthorizationAppleIDCredential) async throws {
        do {
            try await signInWithExistingAccount(credential: credential)
            if let _ = credential.email, let _ = credential.fullName {
                // if can't sign in, sign up
                if await self.parent?.signedInUser.status == .notSignedIn {
                    try await registerNewAccount(credential: credential)
                }
            } else {
                // TODO:: remove account? (eg: signed in on the phone but no record in db)
            }
        } catch let err {
            throw err
        }
    }
    
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) async throws {
        
        var user = UserModel(
            uid: credential.user,
            username: usernameSettings.getDefaultUsername(),
            email: credential.email ?? "email N/A",
            firstName: credential.fullName?.givenName ?? "name N/A",
            lastName: credential.fullName?.familyName ?? "lastname N/A"
        )
        do {
            user = try await userDB.addUserRecord(of: user)
            updateSignedInUser(user: user)
        } catch let err {
            throw err
        }
    }
    
    func updateSignedInUser(user: UserModel) {
        DispatchQueue.main.async {
            self.parent?.signedInUser.user = user
            self.parent?.signedInUser.status = .signedIn
        }
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) async throws {
        
        do {
            let user = try await userDB.fetchUserRecord(with: credential.user)
            updateSignedInUser(user: user)
        } catch let err {
            throw err
        }
    }
}
