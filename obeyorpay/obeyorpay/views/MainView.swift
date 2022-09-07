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
        
        NavigationView {
            
            VStack {
        
            
                if tab == TabItems.tasks {
                    TasksView()
                } else if tab == TabItems.settings {
                    SettingsView()
                }
                
                Spacer()
                
                AppTabView(tab: $tab)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
