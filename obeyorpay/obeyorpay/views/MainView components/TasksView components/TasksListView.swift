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
    @State var showingInviteShareTask = false
    
    
    //var tasks: [TaskStoreModel]
    var taskType: TaskTypes
    
    var viewWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
            
            if taskType != .personal {
                ForEach(signedInUser.user.account.invitedTasks[taskType]!) { task in
                    HStack {
                        Text(task.title)
                        Divider()
                        Spacer()
                        Button {
                            acceptTask(task: task)
                        } label: {
                            Text("accept")
                        }
                        Button {
                            rejectTask(task: task)
                        } label: {
                            Text("reject")
                        }
                        
                    }
                }
            }
            
 
            ForEach(signedInUser.user.account.tasks[taskType]!) { task in
                
                        TaskView(task: task, taskType: taskType)
                    .frame(height: 110)
                        
                        /*
                         NavigationLink {
                         TaskEditingView(task: task, taskType: taskType)
                         } label: {
                         Text("edit")
                         }
                         
                         Button {
                         leaveTask(task: task)
                         } label: {
                         Text("leave")
                         }
                         
                         
                         NavigationLink(isActive: $showingInviteJoinTask) {
                         InviteTaskView(showingThisView: $showingInviteJoinTask, task: task, taskUserType: taskType, taskInvitedType: .joint)
                         } label: {
                         Text("inv-J")
                         }
                         
                         NavigationLink(isActive: $showingInviteShareTask) {
                         InviteTaskView(showingThisView: $showingInviteShareTask, task: task, taskUserType: taskType, taskInvitedType: .shared)
                         } label: {
                         Text("inv-S")
                         }
                         */
                        
                        
                    
                    
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
    
    private func acceptTask(task: TaskStoreModel) {
        do {
            try taskSettings.acceptTask(task: task, taskType: taskType, signedInUser: signedInUser)
        } catch let err {}
    }
    
    private func rejectTask(task: TaskStoreModel) {
        do {
            try taskSettings.rejectTask(task: task, taskType: taskType, signedInUser: signedInUser)
        } catch let err {}
    }
}

//struct TasksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TasksListView()
//    }
//}
