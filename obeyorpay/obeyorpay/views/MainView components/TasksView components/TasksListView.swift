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
    var expandedRowHeight: Double = 150
    
    @State var expandedTasksRefs: [String] = []
    
    var body: some View {
        
        VStack(spacing: -10) {
            
            /// invitations
            if taskType != .personal {
                ForEach(signedInUser.user.account.invitedTasks[taskType]!) { task in
                    TaskRowView(task: task, taskType: taskType, rowHeight: rowHeight, isInviting: true, expandedTasksRefs: $expandedTasksRefs)
                        .frame(height: rowHeight + 5)
                        .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
                }.padding()
            }
            
            /// divider
            if (signedInUser.user.account.invitedTasks[taskType]!.count > 0) && (signedInUser.user.account.tasks[taskType]!.count > 0) {
                Spacer().frame(height: 30)
                Divider()
                    .frame(height: 2)
                    .overlay(theme.unselectedTextColor)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                Spacer().frame(height: 30)
            }
            
            /// tasks
            ForEach(
                signedInUser.user.account.tasks[taskType]!.sorted {
                    if $0.build == $1.build {
                        if $0.span.toInt() == $1.span.toInt() {
                            return (Double($0.currentCount) / Double($0.target)) < (Double($1.currentCount) / Double($1.target))
                        } else {
                            return $0.span.toInt() < $1.span.toInt()
                        }
                        
                    } else {
                        return $0.build.toInt() > $1.build.toInt()
                    }
                }
            ) { task in
                
                HStack {
                    TaskRowView(
                        task: task,
                        taskType: taskType,
                        rowHeight: expandedTasksRefs.contains(task.recordName!) ? expandedRowHeight : rowHeight,
                        isInviting: false,
                        expandedTasksRefs: $expandedTasksRefs
                    )
                        .frame(height: expandedTasksRefs.contains(task.recordName!) ? expandedRowHeight : rowHeight + 5)
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
