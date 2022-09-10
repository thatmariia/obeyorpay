//
//  JoinInviteTaskView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 09/09/2022.
//

import SwiftUI

struct JoinInviteTaskView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    @State var inviting: Bool = false
    @State var invitedUsername: String = ""
    
    @State var invitedNote: String = ""
    @State var showingInvitedNote = false
    
    var body: some View {
        VStack {
            
            Button {
                self.mode.wrappedValue.dismiss()
            } label: {
                Text("close X")
            }
            
            // list all joint
            ForEach(task.jointUsers) { user in
                HStack {
                    Text(user.username)
                    Spacer()
                }
            }
            
            // list all invited
            ForEach(task.jointInvitedUsers) { user in
                HStack {
                    Text(user.username)
                    Spacer()
                    Text("invited")
                }
            }
            
            
            if inviting {
                TextField("Username", text: $invitedUsername)
                
                if showingInvitedNote {
                    Text(invitedNote)
                }
                
                Button {
                    attemptInvitingUser()
                } label: {
                    Text("invite")
                }

            } else {
                Button {
                    inviting = true
                } label: {
                    Text("invite +")
                }
            }

            
        }
    }
    
    private func attemptInvitingUser() {
        var canInvite = true
        
        let invitedComment = taskSettings.invitedUsernameExists(username: invitedUsername)
        if !invitedComment.isCorrect {
            canInvite = false
            showingInvitedNote = true
            invitedNote = invitedComment.note!
        }
        
        if canInvite {
            // invite
            do {
                try taskSettings.inviteUser(with: invitedUsername, to: task, taskUserType: taskType, taskInvitedType: .joint, signedInUser: signedInUser)
            } catch let err {
            }
            showingInvitedNote = false
            invitedNote = ""
            inviting = false
        }
    }
}

//struct JoinInviteTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        JoinInviteTaskView()
//    }
//}
