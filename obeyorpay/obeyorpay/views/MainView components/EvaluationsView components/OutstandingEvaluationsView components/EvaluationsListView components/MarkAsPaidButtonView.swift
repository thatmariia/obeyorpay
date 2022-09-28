//
//  MarkAsPaidButtonView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import SwiftUI

struct MarkAsPaidButtonView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @Binding var outstandingEvaluations: [EvaluationStoreModel]
    @Binding var selectedEvaluations: [EvaluationStoreModel]
    
    @State var alertPaidShowing = false
    @State var alertPaidAction = AlertActions.none
    @State var alertPaidMessage = "Are you sure you have already paid for selected items?"
    

    var body: some View {
        ZStack {
            WithPopover(showPopover: $alertPaidShowing, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
                Button {
                    alertPaidShowing = true
                } label: {
                    Text("MARK AS PAID")
                }
                .buttonStyle(ConfirmButtonStyle())
            } popoverContent: {
                AlertView(
                    bodyMessage: $alertPaidMessage,
                    showingOkButton: true,
                    alertShowing: $alertPaidShowing,
                    alertAction: $alertPaidAction
                )
            }
        }
        .onChange(of: alertPaidAction) { newValue in
            if alertPaidAction == .ok {
                processPayment()
            }
            alertPaidAction = .none
        }
    }
    
    private func processPayment() {
        do {
            try evaluationSettings.pay(for: selectedEvaluations, signedInUser: signedInUser)
            
            for paidEvaluation in selectedEvaluations {
                if let evaluationIndex = outstandingEvaluations.firstIndex(where: { $0.recordName == paidEvaluation.recordName }) {
                    outstandingEvaluations.remove(at: evaluationIndex)
                }
            }
            selectedEvaluations = []

        } catch let err {
            print(err.localizedDescription)
        }
    }
}

//struct MarkAsPaidButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarkAsPaidButtonView()
//    }
//}
