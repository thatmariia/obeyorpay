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
            
            Color.red
            
            VStack {
                TextField("Username", text: $newUsername)
                
                if showingNote {
                    Text(displayNote)
                }
                
                Spacer()
                
                Button {
                    attemptUsernameChange()
                } label: {
                    Text("done")
                }
                
                Spacer()
                
                Button {
                    authentificator.signOut(signedInUser: signedInUser)
                } label: {
                    Text("sign out")
                }
                
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
    
    fileprivate func attemptUsernameChange() {
        //DispatchQueue.main.async {
        //    Task.init {
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
            //}
        //}
    }
}

//struct SettingsEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsEditingView()
//    }
//}
