//
//  TaskInfoView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 01/10/2022.
//

import SwiftUI

struct TaskInfoView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    var isInviting: Bool
    
    var expanded: Bool
    
    var body: some View {
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
                Text("ACCEPT TO VIEW PROGRESS")
                    .font(.caption)
            } else {
                Text("\(task.currentCount) / AT \(task.build ? "LEAST" : "MOST") \(task.target)  •  \(getPeriodLeft())")
                    .font(.caption)
            }
            
            
            if expanded {
                HStack {
                    Text("LAST START DATE:")
                        .font(.caption)
                    Text("\(task.lastPeriodStartDate, formatter: fullDateFormatter)")
                        .font(.system(size: 13, weight: .medium))
                }
                HStack {
                    Text("LAST END DATE:")
                        .font(.caption)
                    Text("\(getEndDate(startDate: task.lastPeriodStartDate, span: task.span), formatter: fullDateFormatter)")
                        .font(.system(size: 13, weight: .medium))
                }
                HStack {
                    Text("COST:")
                        .font(.caption)
                    Text("€" + String(format: "%.2f", task.countCost))
                        .font(.system(size: 13, weight: .medium))
                }
            }
        }
        .animation(.linear, value: expanded)
    }
    
    private func getPeriodLeft() -> String {
        let endDate = getEndDate(startDate: task.lastPeriodStartDate, span: task.span)
        return "\(endDate.offset(from: Date())) LEFT"
        
    }
}

//struct TaskInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskInfoView()
//    }
//}
