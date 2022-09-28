//
//  PaymentLinkInputFieldView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import SwiftUI

struct PaymentLinkInputFieldView: View {
    
    @Binding var paymentLink: String
    @Binding var showingLinkNote: Bool
    @Binding var linkNote: String
    
    var color: Int = 0
    
    @State var alertAction = AlertActions.none
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "PAYMENT LINK")
            
            WithPopover(showPopover: $showingLinkNote, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
                
                TextField("PAYMENT LINK", text: $paymentLink)
                    .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
                
            } popoverContent: {
                AlertView(
                    bodyMessage: $linkNote,
                    alertShowing: $showingLinkNote,
                    alertAction: $alertAction
                )
            }
        }
    }
}

//struct PaymentLinkInputFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentLinkInputFieldView()
//    }
//}
