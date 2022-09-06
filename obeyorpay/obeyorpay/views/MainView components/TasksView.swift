//
//  TasksView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TasksView: View {
    
    @State var task_type = TaskTypes.personal
    
    @EnvironmentObject var tasksData: TasksDataModel
    
    var body: some View {
        
        VStack {
            HStack {
                TasksTypeView(taskType: $task_type)
                
                Spacer()
                
                AddTaskView()
            }
            
            Spacer()
            
            // TODO:: pass tasks of the $task_type
            TasksListView(tasks: tasksData.tasks)
            
            Spacer()
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
