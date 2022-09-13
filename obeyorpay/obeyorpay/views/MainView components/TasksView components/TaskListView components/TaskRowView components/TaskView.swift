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
    
    var body: some View {
        ZStack(alignment: .center) {
            
            ProgressBarView(color: task.color, height: height)
            
            HStack {
                VStack(alignment: .leading) {
                    // usernames
                    UsernamesView(task: task, taskType: taskType)
                    
                    Spacer().frame(height: 5)
                    
                    // task title
                    Text("\(task.title.uppercased())")
                        .font(.system(size: 20, weight: .semibold))
                        .tracking(3)
                    
                    Spacer().frame(height: 3)
                    
                    // progress
                    if isInviting {
                        Text("ACCEPT TO VIEW COUNT")
                            .font(.caption)
                    }
                    Text("\(task.currentCount) OUT OF AT \(task.build ? "LEAST" : "MOST") \(task.target)")
                        .font(.caption)
                    
                    Spacer().frame(height: 10)
                }
                Spacer()
                
                if isInviting {
                    DecisionButtonsView(task: task, taskType: taskType)
                } else {
                    Button {
                        // TODO:: add entry
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(BigPlusButtonStyle(color: task.color))

                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}