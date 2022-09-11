//
//  InviteTaskView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 09/09/2022.
//

import SwiftUI

struct InviteTaskView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @Binding var showingThisView: Bool
    
    var task: TaskStoreModel
    var taskUserType: TaskTypes
    var taskInvitedType: TaskTypes
    
    @State var inviting: Bool = false
    @State var invitedUsername: String = ""
    
    @State var invitedNote: String = ""
    @State var showingInvitedNote = false
    
    var body: some View {
        VStack {
            
            Text(task.title)
            
            Button {
                showingThisView = false
                self.mode.wrappedValue.dismiss()
            } label: {
                Text("close X")
            }
            
            // list all joint
            ForEach(task.users[taskInvitedType]!) { user in
                HStack {
                    Text(user.username)
                    Spacer()
                }
            }
            
            // list all invited
            ForEach(task.invitedUsers[taskInvitedType]!) { user in
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
        .onAppear {
            showingThisView = true
        }
    }
    
    private func attemptInvitingUser() {
        var canInvite = true
        
        let invitedComment = taskSettings.canInviteUser(username: invitedUsername, task: task, taskInvitedType: taskInvitedType)
        if !invitedComment.isCorrect {
            canInvite = false
            showingInvitedNote = true
            invitedNote = invitedComment.note!
        }
        
        if canInvite {
            // invite
            do {
                try taskSettings.inviteUser(with: invitedUsername, to: task, taskUserType: taskUserType, taskInvitedType: taskInvitedType, signedInUser: signedInUser)
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
