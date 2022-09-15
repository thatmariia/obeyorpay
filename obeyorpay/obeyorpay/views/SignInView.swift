//
//  SignInView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var alertShowing = false
    @State var alertAction = AlertActions.none
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                SignInWithAppleButton(.signIn) { request in
                    authentificator.onRequest(request)
                } onCompletion: { result in
                    authentificator.onCompletion(result, signedInUser: signedInUser)
                }
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(width: 200, height: 60, alignment: .center)
            }
            .blur(radius: alertShowing ? 30 : 0)

        }
        .onChange(of: signedInUser.status) { newValue in
            if newValue == .signedIn {
                alertShowing = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
