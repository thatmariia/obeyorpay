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
            
            HStack {
                NavigationLink {
                    AddTaskView()
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(TopActionButtonStyle())
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5))
            
            Spacer()
            
            Button {
                taskType = TaskTypes.personal
            } label: {
                Text("PERSONAL")
                    .foregroundColor(taskType == .personal ? theme.textColor : theme.unselectedTextColor)
            }
            
            
            Spacer()
            
            Button {
                taskType = TaskTypes.joint
            } label: {
                Text("JOINT")
                    .foregroundColor(taskType == .joint ? theme.textColor : theme.unselectedTextColor)
            }
            
            Spacer()
            
            Button {
                taskType = TaskTypes.shared
            } label: {
                Text("SHARED")
                    .foregroundColor(taskType == .shared ? theme.textColor : theme.unselectedTextColor)
            }
            
            //Spacer()
        }
        .font(.system(size: 15, weight: .semibold))
        .padding()
    }
}

struct TasksTypeView_Previews: PreviewProvider {
    
    @State static var task_type = TaskTypes.personal
    
    static var previews: some View {
        TasksTypeView(taskType: $task_type)
    }
}
