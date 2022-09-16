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
    
    @State var showingNote = false
    @State var displayNote = ""
    
    var body: some View {
        
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading, spacing: 35) {
                    
                    HStack(spacing: 20) {
                        Spacer()
                        
                        Button {
                            attemptUsernameChange()
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
                    
                    MainUsernameInputFieldView(username: $newUsername, showingUsernameNote: $showingNote, usernameNote: $displayNote)
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
    
    fileprivate func attemptUsernameChange() {
        do {
            let usernameComment = try usernameSettings.isCorrectUsername(currUsername: currUsername, newUsername: newUsername)
            
            if usernameComment.isCorrect {
                if newUsername != currUsername {
                    try usernameSettings.updateUser(signedInUser: signedInUser, with: newUsername)
                }
                showingNote = false
                displayNote = ""
                self.mode.wrappedValue.dismiss()
            } else {
                showingNote = true
                displayNote = usernameComment.note!
            }
        } catch {}
        
    }
}

//struct SettingsEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsEditingView()
//    }
//}
