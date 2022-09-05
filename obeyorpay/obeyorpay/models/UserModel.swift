//
//  UserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

// https://firebase.google.com/docs/auth/ios/start#add_to_your_app

import Foundation
import Firebase


class UserModel: ObservableObject {
    
    @Published var uid: String
    @Published var username: String
    
    init() {
        self.uid = ""
        self.username = ""
    }
    
    func attach_listener() -> AuthStateDidChangeListenerHandle {
        
        let handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.get_user_information(user: user)
            } else {
                self.reset_user()
            }
        }
        return handle
    }
    
    func reset_user() {
        self.uid = ""
        self.username = ""
    }
    
    func get_user_information(user: User?) {
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            self.uid = user.uid
            // self.email = user.email
            // let photoURL = user.photoURL
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
            }
        }
        
    }
    
    func detach_listener(handle: AuthStateDidChangeListenerHandle) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func signup(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                return
            }
            self.get_user_information(user: user)
        }
    }
    
    func signin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error != nil {
                return
            }
        }
    }
    
    func signout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            // print("Error signing out: %@", signOutError)
            return
        }
        
    }
}
