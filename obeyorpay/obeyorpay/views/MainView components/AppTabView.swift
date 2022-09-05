//
//  TabView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI


enum TabItems {
    case tasks
    case settings
}

struct AppTabView: View {
    
    @Binding var tab: TabItems
    
    
    var body: some View {
        
        HStack {
            
            Button {
                tab = TabItems.tasks
            } label: {
                Text("tasks")
            }
            
            Spacer()
            
            Button {
                tab = TabItems.settings
            } label: {
                Text("settings")
            }
            

        }
        
    }
}

struct AppTabView_Previews: PreviewProvider {
    
    @State static var tab = TabItems.tasks
    
    static var previews: some View {
        AppTabView(tab: $tab)
    }
}
