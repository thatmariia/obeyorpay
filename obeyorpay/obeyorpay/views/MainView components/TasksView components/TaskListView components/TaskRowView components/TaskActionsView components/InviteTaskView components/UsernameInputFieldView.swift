//
//  UsernameInputFieldView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import SwiftUI

struct UsernameInputFieldView: View {
    
    @Binding var username: String
    var showingUsernameNote: Bool
    var usernameNote: String
    
    var color: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            //SectionTitleTextView(txt: "TITLE")
            TextField("", text: $username)
                .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
            if showingUsernameNote {
                Text(usernameNote)
            }
        }
    }
}

//struct UsernameInputFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsernameInputFieldView()
//    }
//}
