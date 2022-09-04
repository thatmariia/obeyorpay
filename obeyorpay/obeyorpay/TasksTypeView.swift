//
//  TasksTypeView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TasksTypeView: View {
    
    @Binding var task_type: TaskTypes
    
    
    var body: some View {
        HStack {
            
            Button {
                task_type = TaskTypes.personal
            } label: {
                Text("personal")
            }

            
            Spacer()
            
            Button {
                task_type = TaskTypes.joint
            } label: {
                Text("joint")
            }
            
            Spacer()
            
            Button {
                task_type = TaskTypes.shared
            } label: {
                Text("shared")
            }
        }
    }
}

struct TasksTypeView_Previews: PreviewProvider {
    
    @State static var task_type = TaskTypes.personal
    
    static var previews: some View {
        TasksTypeView(task_type: $task_type)
    }
}
