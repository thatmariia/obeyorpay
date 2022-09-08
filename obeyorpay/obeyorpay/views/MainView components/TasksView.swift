//
//  TasksView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

enum TaskTypes {
    case personal
    case joint
    case shared
}

struct TasksView: View {
    
    @State var taskType = TaskTypes.personal
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var body: some View {
        
        VStack {
            HStack {
                TasksTypeView(taskType: $taskType)
                
                Spacer()
                
                AddTaskButtonView()
            }
            
            Spacer()
            
            // TODO:: pass tasks of the $task_type
            // TasksListView(tasks: tasksData.tasks)
            TasksListView(tasks: getTypeTasks())
            
            Spacer()
        }
    }
    
    private func getTypeTasks() -> [TaskStoreModel] {
        switch self.taskType {
        case .personal:
            return self.signedInUser.user.account.personalTasks
        case .joint:
            return self.signedInUser.user.account.jointTasks
        case .shared:
            return self.signedInUser.user.account.sharedTasks
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
