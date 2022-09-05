//
//  TaskView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI


struct TaskView: View {
    
    @State var task: TaskDataModel
    
    var body: some View {
        
        
        VStack {
            Text("\(task.title): \(task.count)/\(task.goal)")
            Divider()
        }

    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(
            task: TaskDataModel(title: "personal task number 1", count: 5, goal: 10)
        )
    }
}
