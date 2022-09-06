//
//  SignInView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import Firebase
import AuthenticationServices

struct SignInView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var body: some View {
        
        ZStack {
            
            SignInWithAppleButton(.signIn) { request in
                SignInAppleModel(parent: self).onRequest(request)
            } onCompletion: { result in
                SignInAppleModel(parent: self).onCompletion(result)
            }
            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .frame(width: 200, height: 60, alignment: .center)

        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
