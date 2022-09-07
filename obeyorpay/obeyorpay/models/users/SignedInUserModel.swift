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
    
    @Published var user_old: UserCKModel
    @Published var user: UserStoreModel
    @Published var account: AccountCKModel
    @Published var accountStore: Any
    @Published var status: signInStatus
    @Published var checkedStatusOnStart: Bool
    
    init() {
        self.user_old = UserCKModel()
        self.user = UserStoreModel()
        self.account = AccountCKModel()
        self.accountStore = 5
        self.status = .notSignedIn
        self.checkedStatusOnStart = false
    }
}
