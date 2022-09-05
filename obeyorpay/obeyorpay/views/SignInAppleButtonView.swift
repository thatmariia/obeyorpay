//
//  SignInAppleButtonView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 05/09/2022.
//


import SwiftUI
import AuthenticationServices


struct SignInAppleButtonView: UIViewRepresentable {
    
    @Environment(\.colorScheme) var colorScheme
    
//    func makeCoordinator() -> SignInWithAppleDelegates {
//        return SignInWithAppleDelegates(parent: self)
//    }
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton  {
        //Creating the apple sign in button
        let button = ASAuthorizationAppleIDButton(
            authorizationButtonType: .signIn,
            authorizationButtonStyle: colorScheme == .dark ? .white : .black
        )
        button.cornerRadius = 10
        
        //Adding the tap action on the apple sign in button
        //button.addTarget(context.coordinator, action: #selector(SignInWithAppleDelegates.didTapButton), for: .touchUpInside)
        
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
