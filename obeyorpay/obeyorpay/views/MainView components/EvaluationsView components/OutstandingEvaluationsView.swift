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
    
    init() {
        
        let evaluations = signedInUser.user.account.evaluations.filter { evaluation in
            let paymentsRefs = evaluation.paymentsRefs
            let payments = signedInUser.user.account.payments.filter { paymentsRefs.contains($0.recordName!) }
            let usersRefs = payments.map { $0.user.recordName! }
            return !usersRefs.contains(signedInUser.user.recordName!)
        }
        
        _outstandingEvaluations = State(initialValue: evaluations)
        _selectedEvaluations = State(initialValue: evaluations)
    }
    
    var body: some View {
        VStack {
            
            // TODO: selected amount + pay button crap
            
            EvaluationsListView(outstandingEvaluations: $outstandingEvaluations, selectedEvaluations: $selectedEvaluations)
        }
    }
}

struct OutstandingEvaluationsView_Previews: PreviewProvider {
    static var previews: some View {
        OutstandingEvaluationsView()
    }
}
