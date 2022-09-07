//
//  SettingsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 05/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var body: some View {
        
        
        VStack {
            
            Text(signedInUser.user.username)
        
            Spacer()
            
            NavigationLink {
                SettingsEditingView(currUsername: signedInUser.user.username, newUsername: signedInUser.user.username)
            } label: {
                Text("edit (username)")
            }
            
            Spacer()
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
