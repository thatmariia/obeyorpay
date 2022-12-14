//
//  PayButtonView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import SwiftUI

struct PayButtonView: View {
    @State var alertPayShowing: Bool
    @State var alertPayAction: AlertActions
    @State var alertPayMessage: String
    
    init() {
        _alertPayShowing = State(initialValue: false)
        _alertPayAction = State(initialValue: AlertActions.none)
        _alertPayMessage = State(initialValue: "Please enter a payment link in settings")
    }
    
    var body: some View {
        WithPopover(showPopover: $alertPayShowing, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
            Button {
                let paymentLink = userCD.fetchPaymentLink()
                if paymentLink == "" {
                    alertPayShowing = true
                } else {
                    if paymentLink.contains("https://") {
                        UIApplication.shared.open(URL(string: paymentLink)!)
                    } else {
                        UIApplication.shared.open(URL(string: "https://" + paymentLink)!)
                    }
                }
            } label: {
                Text("PAY NOW")
            }
            .buttonStyle(ConfirmButtonStyle())
        } popoverContent: {
            AlertView(
                bodyMessage: $alertPayMessage,
                showingOkButton: false,
                alertShowing: $alertPayShowing,
                alertAction: $alertPayAction
            )
        }
    }
}

struct PayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PayButtonView()
    }
}
