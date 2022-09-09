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
                
                NavigationLink {
                    AddTaskView()
                } label: {
                    AddTaskButtonView()
                }
            }
            
            Spacer()
            
            Text("\(signedInUser.user.account.tasks[.personal]!.count)")
            
            Spacer()
            
            TasksListView(taskType: taskType)
            
            Spacer()
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
