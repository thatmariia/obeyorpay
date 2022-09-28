//
//  OutstandingEvaluationsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

struct OutstandingEvaluationsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var outstandingEvaluations: [EvaluationStoreModel] = []
    @State var selectedEvaluations: [EvaluationStoreModel] = []
    
    init(evaluations: [EvaluationStoreModel]) {
        
        _outstandingEvaluations = State(initialValue: evaluations)
        _selectedEvaluations = State(initialValue: evaluations)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer().frame(height: 40)
            
            Group {
                Text("€" + String(format: "%.2f", getAmount()))
                    .font(.system(size: 35, weight: .heavy))
                    .tracking(3)
                
                HStack {
                    
                    Button {
                        // TODO: PAYYYYYY
                    } label: {
                        Text("PAY NOW")
                    }
                    .buttonStyle(ConfirmButtonStyle())
                    
                    Spacer().frame(width: 15)
                    
                    Button {
                        // TODO: add the user to the list of payments in evaluation
                    } label: {
                        Text("MARK AS PAID")
                    }
                    .buttonStyle(ConfirmButtonStyle())

                }
            }
            
            Spacer().frame(height: 40)

            
            EvaluationsListView(outstandingEvaluations: $outstandingEvaluations, selectedEvaluations: $selectedEvaluations)
        }
    }
    
    private func getAmount() -> Double {
        let allCosts = selectedEvaluations.map { $0.totalCost / Double($0.jointUsers.count) }
        return allCosts.reduce(0, +)
    }
}

//struct OutstandingEvaluationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutstandingEvaluationsView()
//    }
//}
