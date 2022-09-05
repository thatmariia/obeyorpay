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
    
    @EnvironmentObject var user: UserModel
    
    var body: some View {
        
        VStack {
        
            SignInAppleButtonView()
                .frame(width: 200, height: 60, alignment: .center)
                .onTapGesture {
                    SignInAppleModel(parent: self).didTapButton()
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
