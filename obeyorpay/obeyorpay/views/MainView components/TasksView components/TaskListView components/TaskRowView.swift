//
//  TaskRowView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

enum TaskViewPresentation {
    case task
    case editing
}


struct TaskRowView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    var rowHeight: Double
    
    var isInviting: Bool
    
    @Binding var expandedTasksRefs: [String]
    
    @State var presentation: TaskViewPresentation = .task
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            TabView(selection: $presentation) {
                
                TaskView(task: task, taskType: taskType, height: rowHeight, isInviting: isInviting, expandedTasksRefs: $expandedTasksRefs)
                    .tag(TaskViewPresentation.task)
                
                if (!isInviting) && (!expandedTasksRefs.contains(task.recordName!)) {
                    TaskActionsView(task: task, taskType: taskType, height: rowHeight)
                        .tag(TaskViewPresentation.editing)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            presentation = .task
        }
        
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(
//            task: TaskCKModel()
//        )
//    }
//}
