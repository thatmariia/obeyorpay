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
        
        
        
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 35) {
                    
                    HStack(spacing: 20) {
                        Spacer()
                        
                        Button {
                            self.mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "multiply")
                        }
                        .buttonStyle(DismissButtonStyle())
                    }
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                }
                
                
                VStack(spacing: 35) {
                    
                    SectionTitleTextView(txt: task.title.uppercased(), centering: true)
                    
                    
                    MemberUsersView(task: task, taskInvitedType: taskInvitedType)
                        .padding(25)
                    
                    // inviting
                    
                    if inviting {
                        HStack {
                            UsernameInputFieldView(username: $invitedUsername, showingUsernameNote: showingInvitedNote, usernameNote: invitedNote, color: task.color)
                            
                            Spacer().frame(width: 30)
                            
                            Button {
                                attemptInvitingUser()
                            } label: {
                                Text("INVITE")
                            }
                            .buttonStyle(ConfirmButtonStyle())
                        }
                    } else {
                        Button {
                            inviting = true
                        } label: {
                            Text("INVITE MORE")
                        }
                        .buttonStyle(ConfirmButtonStyle())
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .navigationTitle("")
                .navigationBarHidden(true)
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
