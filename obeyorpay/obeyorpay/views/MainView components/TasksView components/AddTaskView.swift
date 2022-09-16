//
//  AddTaskView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import SwiftUI

struct AddTaskView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var title: String = "Title"
    @State var span: TaskSpan = .day
    @State var spanStartDate: Date = Date()
    //@State var trackBeforeStart: Bool = false
    @State var target: String = "5"
    @State var build: Int = 1
    @State var countCost: String = "1,0"
    @State var color: Int = 0
    
    @State var titleNote: String = ""
    @State var showingTitleNote: Bool = false
    
    @State var targetNote: String = ""
    @State var showingTargetNote: Bool = false
    
    @State var countCostNote: String = ""
    @State var showingCountCostNote: Bool = false
    
    
    var body: some View {
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {

            VStack(alignment: .leading, spacing: 35) {
                
                HStack(spacing: 20) {
                    Spacer()
                    
                    Button {
                        attemptAddingTask()
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
                
                // span start date
                SpanStartDateInputView(spanStartDate: $spanStartDate, color: color)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                // track before start
                // TrackBeforeStartInputView(trackBeforeStart: $trackBeforeStart, color: color)
                //    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                // target and build
                TargetInputView(build: $build, target: $target, showingTargetNote: $showingTargetNote, targetNote: $targetNote, color: color)
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
        //.font(.system(size: 15, weight: .semibold))
    }
    
    private func attemptAddingTask() {
        var canSave = true
        
        let titleComment = taskSettings.isTitleCorrect(title: title)
        if !titleComment.isCorrect {
            canSave = false
            showingTitleNote = true
            titleNote = titleComment.note!
            return
        }
        
        let targetComment = taskSettings.isTargetCorrect(target: target)
        if !targetComment.isCorrect {
            canSave = false
            showingTargetNote = true
            targetNote = targetComment.note!
            return
        }
        
        let countCostComment = taskSettings.isCostCorrect(countCost: countCost)
        if !countCostComment.isCorrect {
            canSave = false
            showingCountCostNote = true
            countCostNote = countCostComment.note!
            return
        }
        
        if canSave {
            
            let task = TaskStoreModel(
                user: signedInUser.user,
                title: title,
                span: span,
                spanStartDate: spanStartDate,
                trackBeforeStart: false,
                target: Int(target)!,
                build: build == 1 ? true : false,
                countCost: Double(countCost.replacingOccurrences(of: ",", with: "."))!,
                color: color
            )
            do {
                try taskSettings.addTask(signedInUser: signedInUser, task: task)
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

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
