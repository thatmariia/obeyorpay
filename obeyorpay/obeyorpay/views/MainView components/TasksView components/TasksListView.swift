//
//  TasksListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import SwiftUI


struct TasksListView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var taskType: TaskTypes
    
    var viewWidth = UIScreen.main.bounds.width
    
    var rowHeight: Double = 100
    
    var body: some View {
        
        VStack(spacing: -10) {
            
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
                
                HStack {
                    TaskRowView(task: task, taskType: taskType, rowHeight: rowHeight)
                        .frame(height: rowHeight + 5)
                        .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
                }
                .padding()
                
            }
        }
        
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
