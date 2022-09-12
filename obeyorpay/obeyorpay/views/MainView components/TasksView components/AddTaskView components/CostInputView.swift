//
//  CostInputView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct CostInputView: View {
    
    @Binding var countCost: String
    
    var showingCountCostNote: Bool
    var countCostNote: String
    
    var color: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "COST PER UNIT €")
            
            TextField("COST", text: $countCost)
                .frame(width: 100)
                .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
                .keyboardType(.decimalPad)
            if showingCountCostNote {
                Text(countCostNote)
            }
        }
    }
}

//struct CostInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        CostInputView()
//    }
//}
