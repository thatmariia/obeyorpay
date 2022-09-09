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
    
    var signedInUser: SignedInUserModel
    
    init() {
        signedInUser = SignedInUserModel()
        checkIfUserSignedIn()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(signedInUser)
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
            //.environment(\.managedObjectContext, userController.container.viewContext)
        }
    }
    
    private func checkIfUserSignedIn() {
        // check if the core data contains a user
        let uid = userCD.fetchUser()
        if uid == nil {
            signedInUser.checkedStatusOnStart = true
            return
        }
        
        // if so, fetch its data
        DispatchQueue.main.async {
            Task.init {
                do {
                    let user = try await mainUserDB.queryMainUser(withKey: UserCKKeys.uid, CKQueryOperation.equal, to: uid!)
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
