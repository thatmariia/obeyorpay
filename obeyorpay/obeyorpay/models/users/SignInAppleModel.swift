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
            
            // try signing in
            signInWithExistingAccount(credential: credential)
            
            if let _ = credential.email, let _ = credential.fullName {
                // if can't sign in, sign up
                if self.parent?.signedInUser.status == .notSignedIn {
                    registerNewAccount(credential: credential)
                }
            } else {
                // TODO:: remove account? (eg: signed in on the phone but no record in db)
            }
        case .failure (let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
    
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        
        let user = UserModel(
            uid: credential.user,
            username: usernameSettings.getDefaultUsername(),
            email: credential.email ?? "email N/A",
            firstName: credential.fullName?.givenName ?? "name N/A",
            lastName: credential.fullName?.familyName ?? "lastname N/A"
        )
        CKDataUserModel().addUserRecord(of: user) { (result) in
            self.hangleResult(of: result)
        }
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        
        CKDataUserModel().fetchUserRecord(with: credential.user) { (result) in
            self.hangleResult(of: result)
        }
    }
    
    private func hangleResult(of result: Result<UserModel, Error>) {
        switch result {
        case .success(let signedInUser):
            DispatchQueue.main.async {
                self.parent?.signedInUser.user = signedInUser
                self.parent?.signedInUser.status = .signedIn
            }
        case .failure(let err):
            DispatchQueue.main.async {
                self.parent?.signedInUser.status = .notSignedIn
                print(err.localizedDescription)
            }
        }
    }
}
