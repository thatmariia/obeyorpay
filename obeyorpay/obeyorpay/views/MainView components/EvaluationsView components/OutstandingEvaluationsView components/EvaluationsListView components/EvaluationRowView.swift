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
    
    var body: some View {
        HStack {
            EvaluationView(evaluation: evaluation, task: task, height: height)
        }
    }
}

//struct EvaluationRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluationRowView()
//    }
//}
