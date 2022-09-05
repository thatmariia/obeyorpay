//
//  SignInWithAppleDelegates.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 05/09/2022.
//

// https://levelup.gitconnected.com/swiftui-login-or-sign-in-with-apple-b540f9ded52f

import UIKit
import AuthenticationServices

class SignInAppleModel: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    var parent: LoginView?
    
    init(parent: LoginView) {
        self.parent = parent
        super.init()
    }
    
    //@objc
    func didTapButton() {
        // https://www.raywenderlich.com/4875322-sign-in-with-apple-using-swiftui
        
        // 1 - All sign in requests need an ASAuthorizationAppleIDRequest.
        let request = ASAuthorizationAppleIDProvider().createRequest()
        
        // 2 - Specify the type of end user data you need to know.
        request.requestedScopes = [.fullName, .email]
        
        //Make the request
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        self.parent?.user.uid = credential.user
        // TODO:: save this somewhere
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        // TODO:: retrieve
        self.parent?.user.uid = credential.user
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let vc = UIApplication.shared.windows.last?.rootViewController
        return (vc?.view.window!)!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
                registerNewAccount(credential: appleIdCredential)
            } else {
                signInWithExistingAccount(credential: appleIdCredential)
            }
            
            break
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
