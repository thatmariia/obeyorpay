//
//  TaskEditingView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TaskEditingView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    @State var title: String
    
    @State var titleNote: String = ""
    @State var showingTitleNote: Bool = false
    
    init(task: TaskStoreModel, taskType: TaskTypes) {
        self.task = task
        self.taskType = taskType
        _title = State(initialValue: task.title)
    }
    
    var body: some View {
        
        VStack {
            
            Button {
                self.mode.wrappedValue.dismiss()
            } label: {
                Text("close X")
            }
            
            Button {
                attemptChangeTask()
            } label: {
                Text("save")
            }
            
            // title
            Group {
                Text("Title")
                TextField("Title", text: $title)
                if showingTitleNote {
                    Text(titleNote)
                }
            }
            
        }
        
    }
    
    private func attemptChangeTask() {
        var canSave = true
        
        let titleComment = taskSettings.isTitleCorrect(title: title)
        if !titleComment.isCorrect {
            canSave = false
            showingTitleNote = true
            titleNote = titleComment.note!
        }
        
        if canSave {

            task.title = title
            do {
                try taskSettings.editTask(signedInUser: signedInUser, task: task, taskType: taskType)
            } catch let err {
                print(err.localizedDescription)
            }
            
            showingTitleNote = false
            titleNote = ""
            self.mode.wrappedValue.dismiss()
        }
    }
}

//struct TaskEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskEditingView()
//    }
//}
