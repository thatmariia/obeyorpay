//
//  ContentView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @EnvironmentObject var SignedInUser: SignedInUserModel
    
    var body: some View {
        
        Group {
        
            if SignedInUser.uid == "" {
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
