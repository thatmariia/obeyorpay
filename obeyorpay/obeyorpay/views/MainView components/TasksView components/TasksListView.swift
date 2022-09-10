//
//  TasksListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import SwiftUI


struct TasksListView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var showingInviteJoinTask = false
    
    //var tasks: [TaskStoreModel]
    var taskType: TaskTypes
    
    var body: some View {
        VStack {
            
            if taskType != .personal {
                Text("Invitations")
                ForEach(signedInUser.user.account.invitedTasks[taskType]!) { task in
                    HStack {
                        Text(task.title)
                        Divider()
                        Spacer()
                        Button {
                            // TODO:: accept
                        } label: {
                            Text("accept")
                        }
                        Button {
                            // TODO:: reject
                        } label: {
                            Text("reject")
                        }

                    }
                }
            }
            
            
            Text("Tasks")
            ForEach(signedInUser.user.account.tasks[taskType]!) { task in
                HStack {
                    
                    NavigationLink {
                        TaskEditingView(task: task, taskType: taskType)
                    } label: {
                        Text("edit")
                    }
                    
                    NavigationLink(isActive: $showingInviteJoinTask) {
                        InviteTaskView(showingThisView: $showingInviteJoinTask, task: task, taskUserType: taskType, taskInvitedType: .joint)
                    } label: {
                        Text("inv-J")
                    }

                    TaskView(task: task)
                }
            }
        }
    }
    
    private func rejectTask() {
        
    }
}

//struct TasksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TasksListView()
//    }
//}
