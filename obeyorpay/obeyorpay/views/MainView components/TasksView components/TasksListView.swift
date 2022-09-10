//
//  TasksListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import SwiftUI


struct TasksListView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    //var tasks: [TaskStoreModel]
    var taskType: TaskTypes
    
    var body: some View {
        VStack {
            ForEach(signedInUser.user.account.tasks[taskType]!) { task in
                HStack {
                    
                    NavigationLink {
                        TaskEditingView(task: task, taskType: taskType)
                    } label: {
                        Text("edit")
                    }
                    
                    NavigationLink {
                        JoinInviteTaskView(task: task, taskType: taskType)
                    } label: {
                        Text("inv-J")
                    }

                    TaskView(task: task)
                }
            }
        }
    }
}

//struct TasksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TasksListView()
//    }
//}
