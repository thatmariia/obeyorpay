//
//  SettingsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 05/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var SignedInUser: SignedInUserModel
    
    var body: some View {
        
        VStack {
            
            Text(SignedInUser.user.username)
        
            Button {
                // TODO:: sign out?
            } label: {
                Text("sign out")
            }
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
