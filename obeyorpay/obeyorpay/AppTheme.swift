//
//  AppTheme.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import Foundation
import SwiftUI


class AppTheme {
    
    var backgroundColor = Color(red: 250/255, green: 250/255, blue: 250/255)
    var shadowColor = Color(red: 220/255, green: 227/255, blue: 228/255) //Color(red: 213/255, green: 221/255, blue: 230/255)
    var cardColor = Color(red: 250/255, green: 250/255, blue: 250/255) //Color.white
    var textColor = Color(red: 69.0/255.0, green: 83.0/255.0, blue: 109.0/255.0)
    var unselectedTextColor = Color(red: 181.0/255.0, green: 186.0/255.0, blue: 196.0/255.0)
    var lightTextColor = Color.white
    var taskColors = [
        Color(red: 201/255, green: 173/255, blue: 255/255),
        Color(red: 242/255, green: 145/255, blue: 171/255),
        Color(red: 253/255, green: 223/255, blue: 126/255),
        Color(red: 149/255, green: 198/255, blue: 185/255),
        Color(red: 238/255, green: 190/255, blue: 203/255),
        Color(red: 172/255, green: 154/255, blue: 155/255),
        Color(red: 183/255, green: 220/255, blue: 225/255),
        Color(red: 255/255, green: 184/255, blue: 109/255),
        Color(red: 154/255, green: 234/255, blue: 179/255),
        Color(red: 121/255, green: 180/255, blue: 242/255)
    ]
    var buttonColor = Color(red: 88/255, green: 218/255, blue: 127/255)
    var alertSize: (CGFloat, CGFloat) = (150, 160)
    // UIScreen.main.bounds.width-150
    
    func getDarkerColor(color: Color) -> Color {
        let factor = 0.7
        let darkerColor = Color(
            red: factor * (color.components?.r ?? 0),
            green: factor * (color.components?.g ?? 0),
            blue: factor * (color.components?.b ?? 0)
        )
        return darkerColor
    }
}

extension Color {
    struct Components {
        var r, g, b, a: Double
    }
    
    var components: Components? {
        guard let components = UIColor(self).cgColor.components?.compactMap(Double.init),
              components.count == 4
        else { return nil}
        return Components(r: components[0], g: components[1], b: components[2], a: components[3])
    }
}
