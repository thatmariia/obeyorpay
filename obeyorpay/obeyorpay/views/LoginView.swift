//
//  LoginView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var appleSignInDelegates: SignInAppleModel! = nil
    
    @EnvironmentObject var SignedInUser: SignedInUserModel
    
    var body: some View {
        
        VStack {
        
            SignInAppleButtonView()
                .frame(width: 200, height: 60, alignment: .center)
                .onTapGesture {
                    SignInViewModel().signin(from: self)
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
