//
//  AuthModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation
import Firebase

class UserModel: ObservableObject {
    
    @Published var id = UUID().uuidString
    @Published var username: String
    
    
    init() {
        self.username = ""
    }

    func attach_listener() -> AuthStateDidChangeListenerHandle {

        let handle = Auth.auth().addStateDidChangeListener { auth, user in
            self.username = user?.displayName ?? "??"
        }
        
        return handle
    }
    
    func detach_listener(handle: AuthStateDidChangeListenerHandle) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
}
