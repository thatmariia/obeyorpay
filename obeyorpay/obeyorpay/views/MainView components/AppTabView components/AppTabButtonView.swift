//
//  AppTabButtonView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct AppTabButtonView: View {
    
    var isSelected: Bool
    var imageSystemName: String
    
    var body: some View {
        Image(systemName: imageSystemName)
            .foregroundColor(isSelected ? theme.textColor : theme.unselectedTextColor )
            //.shadow(color: theme.shadowColor, radius: 3, x: 3, y: 3)
            .font(.system(size: 30, weight: .bold))
    }
}

//struct AppTabButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppTabButtonView()
//    }
//}
