//
//  HistoryPaymentsListView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import SwiftUI

struct HistoryPaymentsListView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var rowHeight: Double = 60
    
    var body: some View {
        VStack(spacing: -10) {
            
            ForEach(signedInUser.user.account.payments.sorted { $0.timestamp > $1.timestamp }) { payment in
                HStack {
                    HistoryPaymentView(payment: payment, height: rowHeight)
                        .frame(height: rowHeight + 5)
                        .shadow(color: theme.shadowColor, radius: 14, x: 10, y: 10)
                }
                .padding()
            }
        }
    }
}

struct HistoryPaymentsListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPaymentsListView()
    }
}
