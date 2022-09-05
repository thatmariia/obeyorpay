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
    
    var tasks_data: TasksDataModel
    var user_model: UserModel
    
    init() {
        tasks_data = TasksDataModel()
        user_model = UserModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasks_data)
                .environmentObject(user_model)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
