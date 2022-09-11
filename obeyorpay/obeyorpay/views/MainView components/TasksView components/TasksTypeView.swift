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
            
            NavigationLink {
                AddTaskView()
            } label: {
                AddTaskButtonView()
            }
            
            Spacer()
            
            Button {
                taskType = TaskTypes.personal
            } label: {
                Text("PERSONAL")
                    .foregroundColor(taskType == .personal ? .black : .gray)
            }

            
            Spacer()
            
            Button {
                taskType = TaskTypes.joint
            } label: {
                Text("JOINT")
                    .foregroundColor(taskType == .joint ? .black : .gray)
            }
            
            Spacer()
            
            Button {
                taskType = TaskTypes.shared
            } label: {
                Text("SHARED")
                    .foregroundColor(taskType == .shared ? .black : .gray)
            }
        }
        .font(.system(size: 15, weight: .semibold))
    }
}

struct TasksTypeView_Previews: PreviewProvider {
    
    @State static var task_type = TaskTypes.personal
    
    static var previews: some View {
        TasksTypeView(taskType: $task_type)
    }
}
