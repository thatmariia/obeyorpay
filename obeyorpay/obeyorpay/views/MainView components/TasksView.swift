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
    
    @State var task_type = TaskTypes.personal
    
    var body: some View {
        
        VStack {
            HStack {
                TasksTypeView(taskType: $task_type)
                
                Spacer()
                
                AddTaskButtonView()
            }
            
            Spacer()
            
            // TODO:: pass tasks of the $task_type
            // TasksListView(tasks: tasksData.tasks)
            
            Spacer()
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
