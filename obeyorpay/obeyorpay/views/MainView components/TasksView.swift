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
    @EnvironmentObject var user: UserModel
    
    var body: some View {
        TasksTypeView(taskType: $task_type)
        
        Spacer()
        
        Text(user.uid)
        
        TasksListView(tasks: tasksData.tasks[task_type] ?? [])
        
        Spacer()
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
