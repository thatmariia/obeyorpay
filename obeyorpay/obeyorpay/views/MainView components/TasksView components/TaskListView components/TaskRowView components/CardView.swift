//
//  CardView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct CardView: View {
    
    var color: Color
    var height: Double
    
    var body: some View {
        GeometryReader { geometry in
        Rectangle()
            .frame(
                width: geometry.size.width,
                height: height
            )
            .foregroundColor(color)
            .cornerRadius(20)
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
