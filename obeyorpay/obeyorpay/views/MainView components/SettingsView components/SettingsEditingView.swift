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
                    let usernameComment = usernameSettings.isCorrectUsername(currUsername: currUsername, newUsername: newUsername)
                    if usernameComment.isCorrect {
                        // TODO:: change username (db + envi)
                        if newUsername != currUsername {
                            signedInUser.user = usernameSettings.updateUser(user: signedInUser.user, with: newUsername)
                        }
                        
                        editing = false
                        isDisplayNotePresent = false
                        displayNote = ""
                    } else {
                        isDisplayNotePresent = true
                        displayNote = usernameComment.note!
                    }
                } label: {
                    Text("done")
                }
                
            }
        }
        
    }
}

//struct SettingsEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsEditingView()
//    }
//}
