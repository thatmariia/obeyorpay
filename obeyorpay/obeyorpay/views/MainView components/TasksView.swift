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
            
            Spacer().frame(height: 10)
                
            TasksTypeView(taskType: $taskType)
            
            Spacer().frame(height: 30)
            
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
