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
    
    var rowHeight: Double = 60
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                selectAllPressed.toggle()
                
                if selectAllPressed {
                    selectedEvaluations = outstandingEvaluations
                } else {
                    selectedEvaluations = []
                }
                
            } label: {
                Text(selectAllPressed ? "DESELECT ALL" : "SELECT ALL")
                    .font(.caption)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
            
            VStack(spacing: -10) {
                
                ForEach(outstandingEvaluations) { evaluation in
                    HStack {
                        EvaluationRowView(evaluation: evaluation, task: getTask(evaluation: evaluation), height: rowHeight, selectedEvaluationsNonBindinding: selectedEvaluations, selectedEvaluations: $selectedEvaluations)
                            .frame(height: rowHeight + 5)
                            .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
                    }
                    .padding()
                }
            }
        }
        .onChange(of: selectedEvaluations) { newValue in
            if newValue.count != outstandingEvaluations.count {
                selectAllPressed = false
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
