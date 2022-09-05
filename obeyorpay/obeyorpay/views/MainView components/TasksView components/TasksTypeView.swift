//
//  TasksTypeView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TasksTypeView: View {
    
    @Binding var taskType: TaskTypes
    
    
    var body: some View {
        HStack {
            
            Button {
                taskType = TaskTypes.personal
            } label: {
                Text("personal")
            }

            
            Spacer()
            
            Button {
                taskType = TaskTypes.joint
            } label: {
                Text("joint")
            }
            
            Spacer()
            
            Button {
                taskType = TaskTypes.shared
            } label: {
                Text("shared")
            }
        }
    }
}

struct TasksTypeView_Previews: PreviewProvider {
    
    @State static var task_type = TaskTypes.personal
    
    static var previews: some View {
        TasksTypeView(taskType: $task_type)
    }
}
