//
//  ContentView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var body: some View {
        
        Group {
        
            if signedInUser.user.uid == "" {
                SignInView()
            } else {
                MainView()
            }
        }
        .padding()
        //.edgesIgnoringSafeArea(.all)
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
