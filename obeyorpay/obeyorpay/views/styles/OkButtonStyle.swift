//
//  OkButtonStyle.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import SwiftUI

struct OkButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundColor(.white)
            .background {
                Rectangle()
                    .foregroundColor(theme.buttonColor)
                    .cornerRadius(20)
                    .shadow(
                        color: theme.shadowColor,
                        radius: configuration.isPressed ? 5 : 10,
                        x: configuration.isPressed ? 5 : 10,
                        y: configuration.isPressed ? 5 : 10
                    )
            }
            .font(.system(size: 15, weight: .medium))
        //.clipShape(Capsule())
    }
}
