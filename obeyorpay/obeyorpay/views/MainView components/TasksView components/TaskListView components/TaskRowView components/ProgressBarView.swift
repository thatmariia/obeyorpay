//
//  ProgressBarView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct ProgressBarView: View {
    
    var color: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        //width: geometry.size.width,
                        height: 95//geometry.size.height
                    )
                    .foregroundColor(theme.cardColor)
                
                Rectangle()
                    .frame(
                        width: min(CGFloat(/*task.currentCount / task.target*/ 0.3) * geometry.size.width, geometry.size.width),
                        height: 95//geometry.size.height
                    )
                    .foregroundColor(theme.taskColors[color])
                    
            }
            .cornerRadius(20)
            
        }
    }
}

//struct ProgressBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBarView()
//    }
//}
