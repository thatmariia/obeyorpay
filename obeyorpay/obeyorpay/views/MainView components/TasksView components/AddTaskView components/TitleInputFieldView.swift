//
//  TitleInputFieldView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct TitleInputFieldView: View {
    
    @Binding var title: String
    var showingTitleNote: Bool
    var titleNote: String
    
    var color: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "TITLE")
            TextField("", text: $title)
                .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
            if showingTitleNote {
                Text(titleNote)
            }
        }
    }
}

//struct TitleInputFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleInputFieldView()
//    }
//}
