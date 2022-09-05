//
//  obeyorpayApp.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import FirebaseCore
import Firebase


@main
struct obeyorpayApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var tasksData: TasksDataModel
    var signedInUser: SignedInUserModel
    
    init() {
        tasksData = TasksDataModel()
        signedInUser = SignedInUserModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksData)
                .environmentObject(signedInUser)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
