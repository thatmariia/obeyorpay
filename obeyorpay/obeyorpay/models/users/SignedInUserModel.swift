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
    
    @Published var user: UserModel
    @Published var status: signInStatus
    @Published var checkedStatusOnStart: Bool
    
    init() {
        self.user = UserModel()
        self.status = .notSignedIn
        self.checkedStatusOnStart = false
    }
}
