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
    
    @State var tab = EvaluationsTabs.outstanding
    
    var body: some View {
        ScrollView {
            VStack {
                
                Spacer().frame(height: 10)
                
                Group {
                    EvaluationsTabsView(tab: $tab)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -15, trailing: 0))
                
                // stuff view
                
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
