//
//  AlertView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import SwiftUI


enum AlertActions {
    case none
    case ok
    case cancel
}

struct AlertView: View {
    
    var bodyMessage: String
    var showingOkButton: Bool = false
    
    @Binding var alertShowing: Bool
    @Binding var alertAction: AlertActions
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(bodyMessage)
                .foregroundColor(theme.textColor)
            
            Spacer()
            
            HStack(spacing: 50) {
                
                Button {
                    alertAction = .cancel
                    alertShowing = false
                } label: {
                    Image(systemName: "multiply")
                }
                .buttonStyle(DismissButtonStyle())
                
                if showingOkButton {
                    Button {
                        alertAction = .ok
                        alertShowing = false
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(OkButtonStyle())
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width-150, height: 200)
        .background {
            Rectangle()
                .foregroundColor(theme.cardColor)
                .cornerRadius(20)
                .shadow(
                    color: theme.shadowColor,
                    radius: 10,
                    x: 10,
                    y: 10
                )
        }
    }
}

//struct AlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertView()
//    }
//}
