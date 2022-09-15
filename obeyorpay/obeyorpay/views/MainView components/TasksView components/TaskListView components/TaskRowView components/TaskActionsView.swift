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
    
    var height: Double
    
    @State var alertShowing = false
    @State var alertAction = AlertActions.none
    
    @State var leavingTaskMessage = "Are you sure you want to leave this task?"
    
    var body: some View {
        ZStack {
            
            HStack {
                
                Spacer()
                
                Group {
                    // removing last entry
                    Button {
                        deleteLastEntry()
                    } label: {
                        TaskActionView(imageSystemName: "gobackward", color: task.color, height: height)
                    }
                    Spacer()
                }
                
                Group {
                    // editing
                    NavigationLink {
                        TaskEditingView(task: task, taskType: taskType)
                    } label: {
                        TaskActionView(imageSystemName: "square.and.pencil", color: task.color, height: height)
                    }
                    Spacer()
                }
                
                
                Group {
                    // inviting joint
                    NavigationLink(isActive: $showingInviteJoinTask) {
                        InviteTaskView(showingThisView: $showingInviteJoinTask, task: task, taskUserType: taskType, taskInvitedType: .joint)
                    } label: {
                        TaskActionView(imageSystemName: "person.fill.badge.plus", color: task.color, height: height)
                    }
                    Spacer()
                }
                
                
                Group {
                    // inviting shared
                    NavigationLink(isActive: $showingInviteShareTask) {
                        InviteTaskView(showingThisView: $showingInviteShareTask, task: task, taskUserType: taskType, taskInvitedType: .shared)
                    } label: {
                        TaskActionView(imageSystemName: "person.wave.2.fill", color: task.color, height: height)
                    }
                    Spacer()
                }
                
                // leaving
                WithPopover(showPopover: $alertShowing, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
                    Group {
                        Button {
                            alertShowing = true
                        } label: {
                            TaskActionView(imageSystemName: "eject.fill", color: task.color, height: height)
                        }
                    }
                } popoverContent: {
                    AlertView(
                        bodyMessage: $leavingTaskMessage,
                        showingOkButton: true,
                        alertShowing: $alertShowing,
                        alertAction: $alertAction
                    )
                }
                
                Spacer()
                
            }

            
        }
        .onChange(of: alertAction) { newValue in
            if alertAction == .ok {
                leaveTask(task: task)
            }
            alertAction = .none
        }
    }
    
    private func leaveTask(task: TaskStoreModel) {
        do {
            try taskSettings.leaveTask(task: task, taskType: taskType == .shared ? .shared : .joint, taskUserType: taskType, signedInUser: signedInUser)
        } catch let err {}
    }
    
    private func deleteLastEntry() {
        do {
            try entrySettings.deleteLastEntry(from: task, taskType: taskType, signedInUser: signedInUser)
        } catch let err {
        }
    }
}

//struct TaskActionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskActionsView()
//    }
//}
