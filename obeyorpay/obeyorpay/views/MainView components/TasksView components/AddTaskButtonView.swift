//
//  AddTaskButtonView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import SwiftUI

struct AddTaskButtonView: View {
    
    var body: some View {
        
        Image(systemName: "plus")
            .foregroundColor(theme.buttonColor)
            .shadow(color: theme.shadowColor, radius: 3, x: 3, y: 3)
            .font(.system(size: 30, weight: .bold))
    }
}

struct AddTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButtonView()
    }
}
