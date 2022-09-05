//
//  LoginView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var user: UserModel
    
    var body: some View {
        
        VStack {
            
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Text(email)
            
            Button {
                user.signin(email: email, password: password)
            } label: {
                Text("sign in")
            }
            
            Button {
                user.signup(email: email, password: password)
            } label: {
                Text("sign up")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
