//
//  obeyorpayApp.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI
import FirebaseCore
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()

    return true
  }
}

@main
struct obeyorpayApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared
    
    @State var handle: AuthStateDidChangeListenerHandle?
    
    var tasks_data: TasksDataModel
    var user_model: UserModel
    
    init() {
        tasks_data = TasksDataModel()
        user_model = UserModel()
        handle = nil
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasks_data)
                .environmentObject(user_model)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    handle = user_model.attach_listener()
                }
                .onDisappear {
                    user_model.detach_listener(handle: handle!)
                }
        }
    }
}
