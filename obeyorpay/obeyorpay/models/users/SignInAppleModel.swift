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
                        do {
                            try signInWithExistingAccount(credential: credential, signedInUser: signedInUser)
                        } catch {
                            try registerNewAccount(credential: credential, signedInUser: signedInUser)
                        }
                    } else {
                        try signInWithExistingAccount(credential: credential, signedInUser: signedInUser)
                    }
                } catch {
                    signedInUser.status = .errorSigningIn
                }
            }
        case .failure (let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
    
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential, signedInUser: SignedInUserModel) throws {
        DispatchQueue.main.async {
            Task.init {
        do {
            //let account = AccountStoreModel()
            let account = try await accountDB.addAccount(account: AccountStoreModel())
            let user = try await mainUserDB.addMainUser(
                user: MainUserStoreModel(
                    uid: credential.user,
                    username: usernameSettings.getDefaultUsername(),
                    email: credential.email ?? "email N/A",
                    firstName: credential.fullName?.givenName ?? "name N/A",
                    lastName: credential.fullName?.familyName ?? "lastname N/A",
                    account: account
                )
            )
            self.updateSignedInUser(user: user, signedInUser: signedInUser)
        } catch let err {
            throw err
        }
            }
        }
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential, signedInUser: SignedInUserModel) throws {
        DispatchQueue.main.async {
            Task.init {
        do {
            let user = try await mainUserDB.queryMainUser(withKey: UserCKKeys.uid, .equal, to: credential.user)
            print(user.uid)
            self.updateSignedInUser(user: user, signedInUser: signedInUser)
        } catch let err {
            throw err
        }
            }
        }
    }
    
    private func updateSignedInUser(user: MainUserStoreModel, signedInUser: SignedInUserModel) {
        userCD.clearCDEntity()
        userCD.addUser(with: user.uid)
        //DispatchQueue.main.async {
            signedInUser.user = user
            signedInUser.status = .signedIn
        //}
        subscriptionDB.subscribe(signedInUser: signedInUser)
    }
    
    func signOut(signedInUser: SignedInUserModel) {
        userCD.clearCDEntity()
        DispatchQueue.main.async {
            signedInUser.user = MainUserStoreModel()
            signedInUser.status = .notSignedIn
        }
    }
}
