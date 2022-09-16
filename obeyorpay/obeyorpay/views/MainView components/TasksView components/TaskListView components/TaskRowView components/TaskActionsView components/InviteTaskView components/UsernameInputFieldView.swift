//
//  UsernameInputFieldView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import SwiftUI

struct UsernameInputFieldView: View {
    
    @Binding var username: String
    @Binding var showingUsernameNote: Bool
    @Binding var usernameNote: String
    
    var color: Int
    
    @State var alertAction = AlertActions.none
    
    var body: some View {
        VStack(alignment: .leading) {
            //SectionTitleTextView(txt: "TITLE")
            
            WithPopover(showPopover: $showingUsernameNote, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
                
                TextField("", text: $username)
                    .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
                
            } popoverContent: {
                AlertView(
                    bodyMessage: $usernameNote,
                    alertShowing: $showingUsernameNote,
                    alertAction: $alertAction
                )
            }
        }
    }
}

//struct UsernameInputFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsernameInputFieldView()
//    }
//}
