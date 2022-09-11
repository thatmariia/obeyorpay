//
//  TaskActionsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct TaskActionsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    @State var showingInviteJoinTask = false
    @State var showingInviteShareTask = false
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Group {
                // emoving last entry
                Button {
                    // TODO:: removing last entry
                } label: {
                    TaskActionView(imageSystemName: "gobackward", color: task.color)
                }
                Spacer()
            }
            
            Group {
                // editing
                NavigationLink {
                    TaskEditingView(task: task, taskType: taskType)
                } label: {
                    TaskActionView(imageSystemName: "square.and.pencil", color: task.color)
                }
                Spacer()
            }
            
            
            Group {
                // inviting joint
                NavigationLink(isActive: $showingInviteJoinTask) {
                    InviteTaskView(showingThisView: $showingInviteJoinTask, task: task, taskUserType: taskType, taskInvitedType: .joint)
                } label: {
                    TaskActionView(imageSystemName: "person.fill.badge.plus", color: task.color)
                }
                Spacer()
            }
            
            
            Group {
                // inviting shared
                NavigationLink(isActive: $showingInviteShareTask) {
                    InviteTaskView(showingThisView: $showingInviteShareTask, task: task, taskUserType: taskType, taskInvitedType: .shared)
                } label: {
                    TaskActionView(imageSystemName: "person.wave.2.fill", color: task.color)
                }
                Spacer()
            }
            
            Group {
                // leaving
                Button {
                    leaveTask(task: task)
                } label: {
                    TaskActionView(imageSystemName: "eject.fill", color: task.color)
                }
                Spacer()
            }
            
        }
    }
    
    private func leaveTask(task: TaskStoreModel) {
        do {
            try taskSettings.leaveTask(task: task, taskType: taskType == .shared ? .shared : .joint, taskUserType: taskType, signedInUser: signedInUser)
        } catch let err {}
    }
}

//struct TaskActionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskActionsView()
//    }
//}
