//
//  TrackBeforeStartInputView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct TrackBeforeStartInputView: View {
    
    @Binding var trackBeforeStart: Bool
    var color: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "TRACK BEFORE START")
            HStack {
                Toggle("", isOn: $trackBeforeStart)
                    .tint(theme.taskColors[color])
                    .labelsHidden()
                Spacer()
            }
        }
    }
}

//struct TrackBeforeStartInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackBeforeStartInputView()
//    }
//}
