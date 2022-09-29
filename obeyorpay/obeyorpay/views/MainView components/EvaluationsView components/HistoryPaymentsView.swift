//
//  HistoryPaymentsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import SwiftUI

struct HistoryPaymentsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var body: some View {
        HistoryPaymentsListView()
    }
}

struct HistoryPaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPaymentsView()
    }
}
