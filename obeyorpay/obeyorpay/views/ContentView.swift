//
//  ContentView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @EnvironmentObject var user: UserModel
    
    var body: some View {
        
        Group {
        
            if user.uid == "" {
                LoginView()
            } else {
                MainView()
            }
        }
        .padding()
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
