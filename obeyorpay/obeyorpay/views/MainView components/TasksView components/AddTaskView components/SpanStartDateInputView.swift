//
//  SpanStartDateInputView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct SpanStartDateInputView: View {
    
    @Binding var spanStartDate: Date
    
    var color: Int
    
    @State var selectingDate = false
    @State var selectingTime = false
    
    var overlayPadding = CGFloat(10)
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "SPAN START DATE")
            
            ZStack(alignment: .center) {
                
                DatePicker("", selection: $spanStartDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    .accentColor(theme.taskColors[color])
                    .opacity(0.0101)
                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                    .background {
                        HStack(spacing: 25) {
                            
                            Text("\(spanStartDate, formatter: dateFormatter)")
                                .foregroundColor(theme.taskColors[color])
                                .padding(EdgeInsets(top: 0, leading: overlayPadding, bottom: 0, trailing: overlayPadding))
                            
                            Text("\(spanStartDate, formatter: timeFormatter)")
                                .foregroundColor(theme.taskColors[color])
                                .padding(EdgeInsets(top: 0, leading: overlayPadding, bottom: 0, trailing: overlayPadding))
                        }
                            //.padding()
                        .font(.system(size: 15, weight: .medium))
                    }
                
            }
            .background {
                Rectangle()
                    .foregroundColor(theme.cardColor)
                    .cornerRadius(20)
                    .shadow(
                        color: theme.shadowColor,
                        radius: 10,
                        x: 10,
                        y: 10
                    )
            }
        }
        
    }
}


//struct SpanStartDateInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpanStartDateInputView()
//    }
//}
