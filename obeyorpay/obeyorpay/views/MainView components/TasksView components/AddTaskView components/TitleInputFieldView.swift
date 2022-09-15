//
//  TitleInputFieldView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct TitleInputFieldView: View {
    
    @Binding var title: String
    @Binding var showingTitleNote: Bool
    @Binding var titleNote: String
    
    var color: Int
    
    @State var alertAction = AlertActions.none
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "TITLE")

            WithPopover(showPopover: $showingTitleNote, popoverSize: CGSize(width: UIScreen.main.bounds.width - theme.alertSize.0, height: theme.alertSize.1)) {
                
                TextField("", text: $title)
                    .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
                
            } popoverContent: {
                AlertView(
                    bodyMessage: $titleNote,
                    alertShowing: $showingTitleNote,
                    alertAction: $alertAction
                )
            }
            

        }
    }
}

//struct TitleInputFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleInputFieldView()
//    }
//}
