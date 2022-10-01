//
//  EvaluationView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

struct EvaluationView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var evaluation: EvaluationStoreModel
    var task: TaskStoreModel
    
    var height: Double
    
    var body: some View {
        ZStack(alignment: .center) {
            
            ProgressBarView(
                color: task.color,
                height: height
            )
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text("\(task.title.uppercased())")
                        .font(.system(size: 13, weight: .semibold))
                    
                    Spacer().frame(height: 5)
                    
                    HStack {
                        Text("S:")
                            .font(.caption)
                        Text("\(evaluation.periodStartDate, formatter: fullDateFormatter)")
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("E:")
                            .font(.caption)
                        Text("\(evaluation.periodEndDate, formatter: fullDateFormatter)")
                            .font(.caption)
                    }
                }
                
                Spacer()
                //Spacer().frame(width: 3)
                
                Text("€" + String(format: "%.2f", evaluation.totalCost / Double(evaluation.jointUsers.count)) )
                    .font(.system(size: 20, weight: .semibold))
                    .tracking(3)
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
    }

}

//struct EvaluationView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluationView()
//    }
//}
