//
//  TabView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI


enum TabItems: CaseIterable {
    case tasks
    case evaluations
    case settings
}

struct AppTabView: View {
    
    @Binding var tab: TabItems
    
    
    var body: some View {
        
        HStack {
            
            Button {
                tab = TabItems.tasks
            } label: {
                AppTabButtonView(isSelected: tab == TabItems.tasks, imageSystemName: "paperclip.circle.fill")
            }
            
            Spacer()
            
            Button {
                tab = TabItems.evaluations
            } label: {
                AppTabButtonView(isSelected: tab == TabItems.evaluations, imageSystemName: "eurosign.circle.fill")
            }
            
            Spacer()
            
            Button {
                tab = TabItems.settings
            } label: {
                AppTabButtonView(isSelected: tab == TabItems.settings, imageSystemName: "gearshape.circle.fill")
            }
            
        }
        .padding()
        
    }
}

struct AppTabView_Previews: PreviewProvider {
    
    @State static var tab = TabItems.tasks
    
    static var previews: some View {
        AppTabView(tab: $tab)
    }
}
