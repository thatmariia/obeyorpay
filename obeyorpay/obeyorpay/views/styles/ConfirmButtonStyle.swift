//
//  ConfirmButtonStyle.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 12/09/2022.
//

import SwiftUI

struct ConfirmButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
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
