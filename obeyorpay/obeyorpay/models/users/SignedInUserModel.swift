//
//  SignedInUserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit
import CoreData


enum signInStatus {
    case signedIn
    case notSignedIn
}

class SignedInUserModel: ObservableObject {
    
    @Published var testname: String
    @Published var user: UserModel
    @Published var status: signInStatus
    
    init() {
        self.testname = "N/A"
        self.user = UserModel(uid: "", username: "", email: "", firstName: "", lastName: "")
        self.status = .notSignedIn
    }
}
