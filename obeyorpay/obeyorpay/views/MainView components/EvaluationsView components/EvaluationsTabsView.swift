//
//  EvaluationsTabsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

struct EvaluationsTabsView: View {
    
    @Binding var tab: EvaluationsTabs
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button {
                tab = .outstanding
            } label: {
                Text("OUTSTANDING")
                    .foregroundColor(tab == .outstanding ? theme.textColor : theme.unselectedTextColor)
            }
            
            Spacer()
            
            Button {
                tab = .history
            } label: {
                Text("HISTORY")
                    .foregroundColor(tab == .history ? theme.textColor : theme.unselectedTextColor)
            }
            
            Spacer()
            
        }
        .font(.system(size: 15, weight: .semibold))
        .padding()
    }
}

//struct EvaluationsTabsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EvaluationsTabsView()
//    }
//}
