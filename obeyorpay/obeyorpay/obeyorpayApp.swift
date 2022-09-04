//
//  obeyorpayApp.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

@main
struct obeyorpayApp: App {
    let persistenceController = PersistenceController.shared
    
    var tasks_data: TasksDataModel
    
    init() {
        tasks_data = TasksDataModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasks_data)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
