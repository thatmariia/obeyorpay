//
//  ProgressBarView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct ProgressBarView: View {
    
    var color: Int
    var height: Double
    
    var count: Int = 1
    var target: Int = 1
    
    var build = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        //width: geometry.size.width,
                        height: height//geometry.size.height
                    )
                    .foregroundColor(build ? theme.cardColor : theme.taskColors[color])
                
                
                Rectangle()
                    .frame(
                        width: min(CGFloat(Double(count) / Double(target)) * geometry.size.width, geometry.size.width),
                        height: height//geometry.size.height
                    )
                    .foregroundColor(build ? theme.taskColors[color] : theme.unselectedTextColor)
                    .animation(.linear(duration: 0.5))
                
                
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
