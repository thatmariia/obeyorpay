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
            .padding(10)
            .foregroundColor(.white)
            .background {
                Rectangle()
                    .foregroundColor(theme.buttonColor)
                    .cornerRadius(20)
                    .shadow(
                        color: theme.shadowColor,
                        radius: 10,
                        x: 10,
                        y: 10
                    )
            }
            .font(.system(size: 15, weight: .medium))
        //.clipShape(Capsule())
    }
}
