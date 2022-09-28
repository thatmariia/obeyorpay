//
//  EvaluationRowView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 28/09/2022.
//

import SwiftUI

struct EvaluationRowView: View {
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var evaluation: EvaluationStoreModel
    var task: TaskStoreModel
    
    var height: Double
    
    @State var selected: Bool
    
    @Binding var selectedEvaluations: [EvaluationStoreModel]
    
    init(evaluation: EvaluationStoreModel, task: TaskStoreModel, height: Double, selectedEvaluationsNonBindinding: [EvaluationStoreModel], selectedEvaluations: Binding<[EvaluationStoreModel]>) {
        self.evaluation = evaluation
        self.task = task
        self.height = height
        self._selected = State(initialValue: selectedEvaluationsNonBindinding.contains(evaluation))
        self._selectedEvaluations = selectedEvaluations
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                selected.toggle()
                
                var newSelectedEvaluations = selectedEvaluations
                
                if selected {
                    newSelectedEvaluations.append(evaluation)
                } else {
                    if let evaluationIndex = newSelectedEvaluations.firstIndex(where: { $0 == evaluation }) {
                        newSelectedEvaluations.remove(at: evaluationIndex)
                    }
                }
                selectedEvaluations = newSelectedEvaluations
                
            } label: {
                Image(systemName: selected ? "circle.fill" : "circle")
                    .foregroundColor(theme.textColor)
                    .font(.system(size: 20, weight: .bold))
            }
            
            Spacer().frame(width: 15)

            EvaluationView(evaluation: evaluation, task: task, height: height)
        }
        .onChange(of: selectedEvaluations) { _ in
            selected = selectedEvaluations.contains(evaluation)
        }
    }
}

//struct EvaluationRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluationRowView()
//    }
//}
