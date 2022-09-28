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
        VStack {
            
            // TODO: selected amount + pay button crap
            
            EvaluationsListView(outstandingEvaluations: $outstandingEvaluations, selectedEvaluations: $selectedEvaluations)
        }
    }
}

//struct OutstandingEvaluationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutstandingEvaluationsView()
//    }
//}
