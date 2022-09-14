//
//  BigPlusButtonStyle.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import SwiftUI


struct BigPlusButtonStyle: ButtonStyle {
    
    var color: Int
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 35, weight: .bold))
            //.padding(20)
            .foregroundColor(theme.getDarkerColor(color: theme.taskColors[color]))
            .opacity(configuration.isPressed ? 0.5 : 0.3)
    }
}
