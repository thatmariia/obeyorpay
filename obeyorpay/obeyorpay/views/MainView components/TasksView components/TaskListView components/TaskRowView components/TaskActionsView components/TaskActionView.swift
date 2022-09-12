//
//  TaskActionView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct TaskActionView: View {
    
    var imageSystemName: String
    var color: Int
    
    var height: Double
    
    var body: some View {
        ZStack(alignment: .center) {
            CardView(color: theme.taskColors[color], height: height)
            
            VStack {
                Image(systemName: imageSystemName)
                    .foregroundColor(theme.textColor)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer().frame(height: 10)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}

//struct TaskActionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskActionView()
//    }
//}
