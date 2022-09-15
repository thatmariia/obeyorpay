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
    @State var span: TaskSpan
    @State var build: Int = 1
    @State var target: String
    @State var countCost: String
    @State var color: Int
    
    @State var titleNote: String = ""
    @State var showingTitleNote: Bool = false
    
    @State var targetNote: String = ""
    @State var showingTargetNote: Bool = false
    
    @State var countCostNote: String = ""
    @State var showingCountCostNote: Bool = false
    
    init(task: TaskStoreModel, taskType: TaskTypes) {
        self.task = task
        self.taskType = taskType
        _title = State(initialValue: task.title)
        _span = State(initialValue: task.span)
        _build = State(initialValue: task.build.toInt())
        _target = State(initialValue: String(task.target))
        _countCost = State(initialValue: String(task.countCost).replacingOccurrences(of: ".", with: ","))
        _color = State(initialValue: task.color)
    }
    
    var body: some View {
        
        
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                
                
                VStack(alignment: .leading, spacing: 35) {
                    
                    HStack(spacing: 20) {
                        Spacer()
                        
                        Button {
                            attemptChangeTask()
                        } label: {
                            Text("SAVE")
                        }
                        .buttonStyle(ConfirmButtonStyle())
                        
                        Button {
                            self.mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "multiply")
                        }
                        .buttonStyle(DismissButtonStyle())
                    }
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                    
                    
                    // title
                    TitleInputFieldView(title: $title, showingTitleNote: $showingTitleNote, titleNote: $titleNote, color: color)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    // span
                    SpanInputButtonsView(span: $span, color: color)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: -30, trailing: 0))
                    
                    // target and build
                    TargetInputView(build: $build, target: $target, showingTargetNote: $showingTargetNote, targetNote: $targetNote, color: color, editing: true)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    // cost per count (unit)
                    CostInputView(countCost: $countCost, showingCountCostNote: $showingCountCostNote, countCostNote: $countCostNote, color: color)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    // color
                    ColorInputView(color: $color)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
        .foregroundColor(theme.textColor)
    
        
    }
    
    private func attemptChangeTask() {
        var canSave = true
        
        let titleComment = taskSettings.isTitleCorrect(title: title)
        if !titleComment.isCorrect {
            canSave = false
            showingTitleNote = true
            titleNote = titleComment.note!
        }
        
        let targetComment = taskSettings.isTargetCorrect(target: target)
        if !targetComment.isCorrect {
            canSave = false
            showingTargetNote = true
            targetNote = targetComment.note!
        }
        
        let countCostComment = taskSettings.isCostCorrect(countCost: countCost)
        if !countCostComment.isCorrect {
            canSave = false
            showingCountCostNote = true
            countCostNote = countCostComment.note!
        }
        
        if canSave {

            task.title = title
            task.span = span
            task.trackBeforeStart = false
            task.target = Int(target)!
            task.countCost = Double(countCost.replacingOccurrences(of: ",", with: "."))!
            task.color = color
            
            do {
                try taskSettings.editTask(signedInUser: signedInUser, task: task, taskType: taskType)
            } catch let err {
                print(err.localizedDescription)
            }
            
            showingTitleNote = false
            titleNote = ""
            showingTargetNote = false
            targetNote = ""
            showingCountCostNote = false
            countCostNote = ""
            self.mode.wrappedValue.dismiss()
        }
    }
}

//struct TaskEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskEditingView()
//    }
//}
