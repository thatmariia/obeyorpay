//
//  SettingsEditingView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import SwiftUI

struct SettingsEditingView: View {
    
    @Binding var editing: Bool
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var currUsername: String
    @State var newUsername: String
    
    @State var isDisplayNotePresent = false
    @State var displayNote = ""
    
    var body: some View {
        
        ZStack {
            
            Color.red
            
            VStack {
                TextField("Username", text: $newUsername)
                
                if isDisplayNotePresent {
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
        
    }
    
    fileprivate func attemptUsernameChange() {
        DispatchQueue.main.async {
            Task.init {
                do {
                    let usernameComment = try await usernameSettings.isCorrectUsername(currUsername: currUsername, newUsername: newUsername)
                    
                    if usernameComment.isCorrect {
                        if newUsername != currUsername {
                            try await usernameSettings.updateUser(signedInUser: signedInUser, with: newUsername)
                        }
                        editing = false
                        isDisplayNotePresent = false
                        displayNote = ""
                    } else {
                        isDisplayNotePresent = true
                        displayNote = usernameComment.note!
                    }
                } catch {}
            }
        }
    }
}

//struct SettingsEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsEditingView()
//    }
//}
