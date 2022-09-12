//
//  SpanButtonStyle.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct SpanButtonStyle: ButtonStyle {
    
    var isSelected: Bool
    var selectedColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .foregroundColor(isSelected ? selectedColor : theme.textColor)
                .background {
                    Rectangle()
                        .foregroundColor(theme.cardColor)
                        .cornerRadius(20)
                        .shadow(
                            color: theme.shadowColor,
                            radius: isSelected ? 5 : 10,
                            x: isSelected ? 5 : 10,
                            y: isSelected ? 5 : 10
                        )
                }
                .font(.system(size: 13, weight: .medium))
                //.clipShape(Capsule())
        }
}

