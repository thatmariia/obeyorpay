//
//  AppTextfieldStyle.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct AppTextfieldStyle: TextFieldStyle {
    
    var accentColor = theme.unselectedTextColor
    var foregroundColor = theme.textColor
    
    public func _body(configuration field: TextField<_Label>) -> some View {
           field
            .textFieldStyle(PlainTextFieldStyle())
            .multilineTextAlignment(.leading)
            .foregroundColor(foregroundColor)
            .accentColor(accentColor)
            .font(.system(size: 16, weight: .medium))
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
            .background {
                Rectangle()
                    .foregroundColor(theme.cardColor)
                    .cornerRadius(20)
                    .shadow(color: theme.shadowColor, radius: 10, x: 10, y: 10)
            }
        }
}
