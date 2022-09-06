//
//  SettingsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 05/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var editing = false
    
    var body: some View {
        
        
        VStack {
            
            Text(signedInUser.user.username)
        
            Spacer()
            
            Button {
                editing = true
            } label: {
                Text("edit (username)")
            }

            
            Spacer()
        }
        .popup(isPresented: $editing) {
            SettingsEditingView(editing: $editing, currUsername: signedInUser.user.username, newUsername: signedInUser.user.username)
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
