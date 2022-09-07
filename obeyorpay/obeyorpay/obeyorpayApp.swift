//
//  obeyorpayApp.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI


@main
struct obeyorpayApp: App {
    
    // let persistenceController = PersistenceController.shared
    
    //@StateObject private var userController = CDDataUserModel()
    
    var tasksData: TasksDataModel
    var signedInUser: SignedInUserModel
    
    init() {
        tasksData = TasksDataModel()
        signedInUser = SignedInUserModel()
        checkIfUserSignedIn()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksData)
                .environmentObject(signedInUser)
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
            //.environment(\.managedObjectContext, userController.container.viewContext)
        }
    }
    
    private func checkIfUserSignedIn() {
        // check if the core data contains a user
        let uid = userCD.fetchUser()
        print("*_*_*_*_*_* app start checking for \(uid)")
        if uid == nil {
            signedInUser.checkedStatusOnStart = true
            return
        }
        
        // if so, fetch its data
        print("*_*_*_*_*_* app start fetching for \(uid)")
        DispatchQueue.main.async {
            Task.init {
                do {
                    let user = try await userDB.fetchUserRecord(with: uid!)
                    signedInUser.user = user
                    signedInUser.status = .signedIn
                    signedInUser.checkedStatusOnStart = true
                } catch {
                    signedInUser.checkedStatusOnStart = true
                }
            }
        }
    }
}
