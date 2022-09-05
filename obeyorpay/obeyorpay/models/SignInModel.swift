//
//  SignInModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 05/09/2022.
//

import Foundation
import AuthenticationServices

class SignInModel {
    
    
    var apple_signin_delegates: SignInAppleModel! = nil
    
    func apple_login() {
//        // https://www.raywenderlich.com/4875322-sign-in-with-apple-using-swiftui
//
//        // 1 - All sign in requests need an ASAuthorizationAppleIDRequest.
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//
//        // 2 - Specify the type of end user data you need to know.
//        request.requestedScopes = [.fullName, .email]
//
//        // 3 - Generate the controller which will display the sign in dialog.
//        //let controller = ASAuthorizationController(authorizationRequests: [request])
//
//        // self.apple_perform_login(using: [request])
//
//        //Make the request
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.presentationContextProvider = self
//        authorizationController.delegate = self
//        authorizationController.performRequests()
    }
    
    func apple_perform_login(using requests: [ASAuthorizationRequest]) {
//        apple_signin_delegates = SignInWithAppleDelegates() { success in
//          if success {
//            // update UI
//          } else {
//            // show the user an error
//          }
//        }
//
//        let controller = ASAuthorizationController(authorizationRequests: requests)
//        controller.delegate = apple_signin_delegates
//        controller.presentationContextProvider = apple_signin_delegates
//
//        controller.performRequests()
    }
    
}
