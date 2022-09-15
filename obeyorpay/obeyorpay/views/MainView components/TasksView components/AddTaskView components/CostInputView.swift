//
//  CostInputView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct CostInputView: View {
    
    @Binding var countCost: String
    
    @Binding var showingCountCostNote: Bool
    @Binding var countCostNote: String
    
    var color: Int
    
    @State var alertAction = AlertActions.none
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "COST PER UNIT €")
            
            WithPopover(showPopover: $showingCountCostNote, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
                
                TextField("COST", text: $countCost)
                    .frame(width: 100)
                    .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
                    .keyboardType(.decimalPad)
            } popoverContent: {
                AlertView(
                    bodyMessage: $countCostNote,
                    alertShowing: $showingCountCostNote,
                    alertAction: $alertAction
                )
            }
        }
    }
}

//struct CostInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        CostInputView()
//    }
//}
