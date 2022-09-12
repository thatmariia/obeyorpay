//
//  SpanInputButtonsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct SpanInputButtonsView: View {
    
    @Binding var span: TaskSpan
    
    var color: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "SPAN")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -15, trailing: 0))
            ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(TaskSpan.allCases, id: \.self) { s in
                    Button {
                        span = s
                    } label: {
                        Text(s.rawValue)
                    }
                    .buttonStyle(SpanButtonStyle(isSelected: span == s, selectedColor: theme.taskColors[color]))
                    //.padding(.trailing, 10)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 30, trailing: 20))
                }
                Spacer()
            }
            }
        }
        //.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -60))
    }
}

//struct SpanInputButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpanInputButtonsView()
//    }
//}
