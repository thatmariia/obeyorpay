//
//  TaskView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct TaskView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    var height: Double
    
    var isInviting: Bool
    
    @Binding var expandedTasksRefs: [String]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            
            ProgressBarView(
                color: task.color,
                height: height,
                count: getProgressBarCount(),
                target: task.target,
                build: task.build
            )
            
            HStack {
                TaskInfoView(
                    task: task,
                    taskType: taskType,
                    isInviting: isInviting,
                    expanded: expandedTasksRefs.contains(task.recordName!)
                )
                    .onLongPressGesture {
                        var updatedExpandedTasksRefs = expandedTasksRefs
                        if expandedTasksRefs.contains(task.recordName!) {
                            if let taskRefIndex = updatedExpandedTasksRefs.firstIndex(where: { $0 == task.recordName! }) {
                                updatedExpandedTasksRefs.remove(at: taskRefIndex)
                            }
                        } else {
                            updatedExpandedTasksRefs.append(task.recordName!)
                        }
                        expandedTasksRefs = updatedExpandedTasksRefs
                    }
                
                Spacer()
                
                if isInviting {
                    DecisionButtonsView(task: task, taskType: taskType)
                } else {
                    if !expandedTasksRefs.contains(task.recordName!) {
                        Button {
                            addEntry()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .buttonStyle(BigPlusButtonStyle(color: task.color))
                    }

                }
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        }
    }
    
    private func getProgressBarCount() -> Int {
        
        if isInviting {
            return task.target
        }
        if expandedTasksRefs.contains(task.recordName!) {
            return 0
        }
        return task.currentCount
        
    }
    
    func addEntry() {
        let entry = EntryStoreModel(user: signedInUser.user, task: task)
        do {
            try entrySettings.addEntry(entry: entry, task: task, taskType: taskType, signedInUser: signedInUser)
        } catch let err {

        }
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}
