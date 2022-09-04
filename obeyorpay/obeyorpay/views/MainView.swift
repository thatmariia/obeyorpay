//
//  MainView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var tab = TabItems.tasks
    
    var body: some View {
        

        if tab == TabItems.tasks {
            TasksView()
        } else if tab == TabItems.settings {
            Text("Settings")
        }
        
        Spacer()
        
        AppTabView(tab: $tab)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
