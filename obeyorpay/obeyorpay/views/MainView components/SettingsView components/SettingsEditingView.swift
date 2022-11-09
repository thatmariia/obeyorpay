//
//  SettingsEditingView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import SwiftUI

struct SettingsEditingView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var currUsername: String
    @State var newUsername: String
    @State var newPaymentLink: String
    @Binding var paymentLink: String
    
    @State var showingUsernameNote = false
    @State var displayUsernameNote = ""
    
    @State var showingLinkNote = false
    @State var displayLinkNote = ""
    
    var body: some View {
        
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading, spacing: 35) {
                    
                    HStack(spacing: 20) {
                        Spacer()
                        
                        Button {
                            attemptSave()
                        } label: {
                            Text("SAVE")
                        }
                        .buttonStyle(ConfirmButtonStyle())
                        
                        Button {
                            self.mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "multiply")
                        }
                        .buttonStyle(DismissButtonStyle())
                    }
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                    
                    MainUsernameInputFieldView(username: $newUsername, showingUsernameNote: $showingUsernameNote, usernameNote: $displayUsernameNote)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    PaymentLinkInputFieldView(paymentLink: $newPaymentLink, showingLinkNote: $showingLinkNote, linkNote: $displayLinkNote)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    
                    Spacer()
                    
                }
                
                VStack {
                    Button {
                        authentificator.signOut(signedInUser: signedInUser)
                    } label: {
                        Text("SIGN OUT")
                    }
                    .buttonStyle(DismissButtonStyle())
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
    }
    
    fileprivate func attemptSave() {
        if attemptUsernameChange() && attemptingLinkChange() {
            self.mode.wrappedValue.dismiss()
        }
    }
    
    fileprivate func attemptingLinkChange() -> Bool {
        let linkComment = linkSettings.isCorrectLink(link: newPaymentLink)
        
        if linkComment.isCorrect {
            linkSettings.updateLink(link: newPaymentLink, signedInUser: signedInUser)
            
            showingLinkNote = false
            displayLinkNote = ""
            
            paymentLink = newPaymentLink
            
            return true
        } else {
            //
            return false
        }
    }
    
    fileprivate func attemptUsernameChange() -> Bool {
        do {
            let usernameComment = try usernameSettings.isCorrectUsername(currUsername: currUsername, newUsername: newUsername)
            
            if usernameComment.isCorrect {
                if newUsername != currUsername {
                    try usernameSettings.updateUser(signedInUser: signedInUser, with: newUsername)
                }
                showingUsernameNote = false
                displayUsernameNote = ""
                return true
            } else {
                showingUsernameNote = true
                displayUsernameNote = usernameComment.note!
                
                return false
            }
        } catch {
            return false
        }
        
    }
}

//struct SettingsEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsEditingView()
//    }
//}
