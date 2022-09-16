//
//  TopActionButtonStyle.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

struct TopActionButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(theme.buttonColor)
            .shadow(color: theme.shadowColor, radius: 3, x: 3, y: 3)
            .font(.system(size: 30, weight: .bold))
    }
}
