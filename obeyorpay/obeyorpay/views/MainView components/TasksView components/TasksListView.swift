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
                    TaskRowView(task: task, taskType: taskType, rowHeight: rowHeight, isInviting: true)
                        .frame(height: rowHeight + 5)
                        .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
                }
            }
            
            if signedInUser.user.account.invitedTasks[taskType]!.count > 0 {
                Spacer().frame(height: 30)
                Divider()
                    .frame(height: 2)
                    .overlay(theme.unselectedTextColor)
                Spacer().frame(height: 30)
            }
            
            ForEach(signedInUser.user.account.tasks[taskType]!) { task in
                
                HStack {
                    TaskRowView(task: task, taskType: taskType, rowHeight: rowHeight, isInviting: false)
                        .frame(height: rowHeight + 5)
                        .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
                }
                .padding()
                
            }
        }
        
    }
    
}

//struct TasksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TasksListView()
//    }
//}
