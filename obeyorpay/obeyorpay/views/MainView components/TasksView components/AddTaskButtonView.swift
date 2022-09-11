//
//  AddTaskButtonView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import SwiftUI

struct AddTaskButtonView: View {
    
    var body: some View {
        
        Image(systemName: "plus.circle.fill")
            .foregroundColor(Color.green)
            .font(.system(size: 25, weight: .regular))


    }
}

struct AddTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButtonView()
    }
}
