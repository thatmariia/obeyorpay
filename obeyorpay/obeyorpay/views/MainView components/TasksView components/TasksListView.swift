//
//  TaskListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TasksListView: View {
    
    var tasks: [TaskModel]
    
    @State var editing = false
    
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(tasks, id: \.self) { task in
                    HStack {
                        TaskView(task: task)
                        
                        Button {
                            // TODO:: decrement count
                        } label: {
                            Text("-")
                        }
                        
                        Button {
                            // TODO:: increment count
                        } label: {
                            Text("+")
                        }
                        
                        Button {
                            // TODO:: edit task
                            editing = true
                        } label: {
                            Text("edit")
                        }
                        
                    }
                }
            }
            .popup(
                isPresented: $editing
            ) {
                TaskEditingView(editing: $editing)
            }
        }
        
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(
            tasks: []
        )
    }
}
