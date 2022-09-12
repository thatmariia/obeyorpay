//
//  ColorInputView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct ColorInputView: View {
    
    @Binding var color: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "COLOR")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<theme.taskColors.count, id: \.self) { i in
                            Button {
                                color = i
                            } label: {
                                Circle()
                                    .strokeBorder(theme.textColor.opacity(color == i ? 1 : 0), lineWidth: 2)
                                    .background(Circle().foregroundColor(theme.taskColors[i]))
                                    .frame(width: 30, height: 30)
                                    .shadow(color: theme.shadowColor, radius: 5, x: 5, y: 5)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 30))
                    }
                }
            }
        }
    }
}

//struct ColorInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorInputView()
//    }
//}
