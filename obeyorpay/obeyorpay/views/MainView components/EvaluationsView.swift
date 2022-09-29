//
//  EvaluationsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

enum EvaluationsTabs {
    case outstanding
    case history
}

struct EvaluationsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var tab = EvaluationsTabs.outstanding
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                Spacer().frame(height: 10)
                
                Group {
                    EvaluationsTabsView(tab: $tab)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -15, trailing: 0))
                
                switch tab {
                case .outstanding:
                    OutstandingEvaluationsView(
                        evaluations: signedInUser.user.account.evaluations.filter { evaluation in
                            let paymentsRefs = evaluation.paymentsRefs
                            let payments = signedInUser.user.account.payments.filter { paymentsRefs.contains($0.recordName!)
                                
                            }
                            let usersRefs = payments.map { $0.user.recordName! }
                            return !usersRefs.contains(signedInUser.user.recordName!)
                        }
                    )
                case .history:
                    HistoryPaymentsView()
                }
                
                Spacer()
            }
        }
    }
}

//struct EvaluationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluationsView()
//    }
//}
