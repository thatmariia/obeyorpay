//
//  TaskView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI


struct TaskView: View {
    
    @State var task: TaskModel
    
    var body: some View {
        
        
        VStack {
            Text("\(task.title): \(task.currentCount)/\(task.target)")
            Divider()
        }

    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(
            task: TaskModel()
        )
    }
}
