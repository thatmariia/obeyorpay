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
    
    @State var title: String = ""
    @State var span: TaskSpan = .day
    @State var spanStartDate: Date = Date()
    @State var trackBeforeStart: Bool = false
    @State var target: String = "5"
    @State var build: Int = 1
    @State var countCost: String = "1,0"
    @State var color: Int = 1
    
    @State var titleNote: String = ""
    @State var showingTitleNote: Bool = false
    
    @State var targetNote: String = ""
    @State var showingTargetNote: Bool = false
    
    @State var countCostNote: String = ""
    @State var showingCountCostNote: Bool = false
    
    
    var body: some View {
        VStack {
            
            Button {
                self.mode.wrappedValue.dismiss()
            } label: {
                Text("close X")
            }
            
            Button {
                var canSave = true
                
                let titleComment = addTaskSettings.isTitleCorrect(title: title)
                if !titleComment.isCorrect {
                    canSave = false
                    showingTitleNote = true
                    titleNote = titleComment.note!
                }
                
                let targetComment = addTaskSettings.isTargetCorrect(target: target)
                if !targetComment.isCorrect {
                    canSave = false
                    showingTargetNote = true
                    targetNote = targetComment.note!
                }
                
                let countCostComment = addTaskSettings.isCostCorrect(countCost: countCost)
                if !countCostComment.isCorrect {
                    canSave = false
                    showingCountCostNote = true
                    countCostNote = countCostComment.note!
                }
                
                if canSave {
                    showingTitleNote = false
                    titleNote = ""
                    showingTargetNote = false
                    targetNote = ""
                    showingCountCostNote = false
                    countCostNote = ""
                    
                    let task = TaskCKModel(
                        user: signedInUser.user,
                        title: title,
                        span: span,
                        spanStartDate: spanStartDate,
                        trackBeforeStart: trackBeforeStart,
                        target: Int(target)!,
                        build: build == 1 ? true : false,
                        countCost: Double(countCost.replacingOccurrences(of: ",", with: "."))!,
                        color: color
                    )
                    
                    DispatchQueue.main.async {
                        // save the task
                        // if everything goes ok: self.mode.wrappedValue.dismiss()
                    }
                }
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
            
            // span
            Group {
                Text("Span")
                HStack {
                    ForEach(TaskSpan.allCases, id: \.self) { s in
                        HStack {
                            Button {
                                span = s
                            } label: {
                                SpanButtonView(txt: s.rawValue)
                            }
                            Divider()
                        }
                    }
                    Spacer()
                }
            }
            
            // span start date
            Group {
                Text("Span start date")
                DatePicker("date picker", selection: $spanStartDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
            }
            
            // track before start
            Group {
                Toggle("Track before start", isOn: $trackBeforeStart)
            }
            
            //
            Group {
                Text("Target")
                HStack {
                    // build (at most vs at least)
                    Menu(build == 1 ? "at least" : "at most") {
                        Button {
                            build = 1
                        } label: {
                            Text("at least")
                        }
                        Button {
                            build = 0
                        } label: {
                            Text("at most")
                        }
                        
                    }
                    // target
                    TextField("Target", text: $target)
                        .keyboardType(.numberPad)
                    if showingTargetNote {
                        Text(targetNote)
                    }
                }
            }
            
            // cost per count (unit)
            Group {
                Text("Cost per unit")
                TextField("Cost", text: $countCost)
                    .keyboardType(.decimalPad)
                if showingCountCostNote {
                    Text(countCostNote)
                }
            }
            
            // TODO:: color
            Group {
                Text("Color")
            }
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
