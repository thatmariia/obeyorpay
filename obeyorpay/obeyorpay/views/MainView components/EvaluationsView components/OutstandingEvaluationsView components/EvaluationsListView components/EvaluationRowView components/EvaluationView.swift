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
                
                Text("\(task.title.uppercased())")
                    .font(.caption)
                
                Spacer()
                Spacer().frame(height: 3)
                
                Text("€" + String(format: "%.2f", evaluation.totalCost / Double(evaluation.jointUsers.count)) )
                    .font(.system(size: 20, weight: .semibold))
                    .tracking(3)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }

}

//struct EvaluationView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluationView()
//    }
//}
