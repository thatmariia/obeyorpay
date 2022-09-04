//
//  TasksView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TasksView: View {
    
    @State var task_type = TaskTypes.personal
    
    var body: some View {
        TasksTypeView(task_type: $task_type)
        
        Spacer()
        
        if task_type == TaskTypes.personal {
            Text("Personal tasks")
        } else if task_type == TaskTypes.joint {
            Text("Joint tasks")
        } else if task_type == TaskTypes.shared {
            Text("Shared tasks")
        }
        
        Spacer()
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
