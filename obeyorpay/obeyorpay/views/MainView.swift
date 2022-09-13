//
//  MainView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    @State var tab = TabItems.tasks
    
    var body: some View {
        
        
        NavigationView {
            ZStack{
                theme.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                switch tab {
                case .tasks:
                    TasksView()
                case .evaluations:
                    Text("Evaluations")
                case .settings:
                    SettingsView()
                }
                
                Spacer()
                
                AppTabView(tab: $tab)
            }
            .foregroundColor(theme.textColor)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .refreshable {
                do {
                    try mainSettings.refreshUserData(signedInUser: signedInUser)
                } catch let err {
                    print("err: ", err.localizedDescription)
                }
            }
        
        }
        
        
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
