//
//  TaskListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TasksListView: View {
    
    var tasks: [TaskDataModel]
    
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(tasks, id: \.self) { task in
                    TaskView(task: task)
                }
            }
        }
        
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(
            tasks: [
                TaskDataModel(title: "shared task number 1", count: 5, goal: 10),
                TaskDataModel(title: "shared task number 2", count: 4, goal: 6)
            ]
        )
    }
}
