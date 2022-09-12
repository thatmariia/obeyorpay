//
//  SectionTitleTextView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct SectionTitleTextView: View {
    
    var txt: String
    
    var body: some View {
        HStack {
            Text(txt)
                .tracking(2)
                .foregroundColor(theme.textColor)
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
    }
}

//struct SectionTitleTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionTitleTextView()
//    }
//}
