//
//  SettingsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 05/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var paymentLink = userCD.fetchPaymentLink()
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    Spacer().frame(height: 10)
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            SettingsEditingView(currUsername: signedInUser.user.username, newUsername: signedInUser.user.username, newPaymentLink: paymentLink, paymentLink: $paymentLink)
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 25, weight: .bold))
                        }
                        .buttonStyle(TopActionButtonStyle())
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5))
                
                VStack(alignment: .leading, spacing: 35) {
                    
                    VStack(alignment: .leading) {
                        Text("Hi,")
                            .font(.system(size: 35, weight: .heavy))
                        Text("@" + signedInUser.user.username)
                            .font(.system(size: 20, weight: .semibold))
                            .tracking(3)
                    }
                    
                    VStack(alignment: .leading) {
                        SectionTitleTextView(txt: "PAYMENT LINK")
                        Text(paymentLink == "" ? "No payment link provided" : paymentLink)
                            .foregroundColor(theme.taskColors[0])
                    }
                    
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
