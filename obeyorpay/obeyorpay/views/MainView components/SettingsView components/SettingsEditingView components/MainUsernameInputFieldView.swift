//
//  MainUsernameInputFieldView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import SwiftUI

struct MainUsernameInputFieldView: View {
    @Binding var username: String
    @Binding var showingUsernameNote: Bool
    @Binding var usernameNote: String
    
    var color: Int = 0
    
    @State var alertAction = AlertActions.none
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "USERNAME")
            
            WithPopover(showPopover: $showingUsernameNote, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
                HStack {
                    Text("@")
                        .foregroundColor(theme.textColor)
                    TextField("USERNAME", text: $username)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
                }
                
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

//struct MainUsernameInputFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainUsernameInputFieldView()
//    }
//}
