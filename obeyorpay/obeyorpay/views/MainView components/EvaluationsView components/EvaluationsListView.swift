//
//  EvaluationsListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

struct EvaluationsListView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var body: some View {
        VStack(spacing: -10) {
            
            ForEach(
                signedInUser.user.account.evaluations.filter { evaluation in
                    let paymentsRefs = evaluation.paymentsRefs
                    let payments = signedInUser.user.account.payments.filter { paymentsRefs.contains($0.recordName!) }
                    let usersRefs = payments.map { $0.user.recordName! }
                    return !usersRefs.contains(signedInUser.user.recordName!)
                }
            ) { evaluation in
                Text("\(evaluation.periodEndDate)")
            }
            
            
//            ForEach(signedInUser.user.account.tasks[taskType]!) { task in
//
//                HStack {
//                    TaskRowView(task: task, taskType: taskType, rowHeight: rowHeight, isInviting: false)
//                        .frame(height: rowHeight + 5)
//                        .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
//                }
//                .padding()
//
//            }
        }
    }
}

struct EvaluationsListView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluationsListView()
    }
}
