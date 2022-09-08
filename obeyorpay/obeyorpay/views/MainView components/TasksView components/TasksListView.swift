//
//  TasksListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import SwiftUI


struct TasksListView: View {
    
    var tasks: [TaskStoreModel]
    
    var body: some View {
        VStack {
            ForEach(tasks) { task in
                Text(task.title)
            }
        }
    }
}

//struct TasksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TasksListView()
//    }
//}
