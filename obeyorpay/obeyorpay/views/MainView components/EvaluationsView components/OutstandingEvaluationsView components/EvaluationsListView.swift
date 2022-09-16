//
//  EvaluationsListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

struct EvaluationsListView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @Binding var outstandingEvaluations: [EvaluationStoreModel]
    
    @State var selectAllPressed = true
    @Binding var selectedEvaluations: [EvaluationStoreModel]
    
    var rowHeight = 100
    
    var body: some View {
        VStack(spacing: -10) {
            
            ForEach(outstandingEvaluations) { evaluation in
                HStack {
                    // TODO: create EvaluationRowView and make EvaluationView a part of it
                    // TODO: in EvaluationRowView, create a selecting panel
                    // TODO: call EvaluationRowView here
                    //                    .frame(height: rowHeight + 5)
                    //                    .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
                }
                .padding()
            }
        }
    }
    
    func getTask(evaluation: EvaluationStoreModel) -> TaskStoreModel {
        if let taskIndex = signedInUser.user.account.tasks[.personal]!.firstIndex(where: { $0.recordName == evaluation.taskRef }) {
            return signedInUser.user.account.tasks[.personal]![taskIndex]
        }
        if let taskIndex = signedInUser.user.account.tasks[.joint]!.firstIndex(where: { $0.recordName == evaluation.taskRef }) {
            return signedInUser.user.account.tasks[.joint]![taskIndex]
        }
        return TaskStoreModel()
    }
}

//struct EvaluationsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluationsListView()
//    }
//}
