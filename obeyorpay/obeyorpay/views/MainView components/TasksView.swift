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
        
        ScrollView {
            VStack {
                
                Spacer().frame(height: 10)
                
                Group {
                    TasksTypeView(taskType: $taskType)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -15, trailing: 0))
                
                TasksListView(taskType: taskType)
                
                Spacer()
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
