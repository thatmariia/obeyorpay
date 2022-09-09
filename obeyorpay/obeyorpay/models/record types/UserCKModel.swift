//
//  MainUserCKModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit


enum UserCKKeys: String, CaseIterable {
    case uid = "uid"
    case username = "username"
    case email = "email"
    case firstName = "firstName"
    case lastName = "lastName"
    case accountRef = "account"
}


class UserCKModel {
    
    var recordName: String?
    var uid: String
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var accountRef: String
    
    init() {
        self.recordName = nil
        self.uid = ""
        self.username = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.accountRef = ""
    }
    
    init(
        recordName: String,
        uid: String,
        username: String,
        email: String,
        firstName: String,
        lastName: String,
        accountRef: String
    ) {
        self.recordName = recordName
        self.uid = uid
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.accountRef = accountRef
    }
    
    init(
        recordName: String,
        username: String,
        email: String,
        firstName: String,
        lastName: String
    ) {
        self.recordName = recordName
        self.uid = ""
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.accountRef = ""
    }
    
    
    func toMainStore() async -> MainUserStoreModel {
        do {
            let account = try await accountDB.fetchAccount(with: self.accountRef)
            let user = MainUserStoreModel(
                recordName: self.recordName ?? "",
                uid: self.uid,
                username: self.username,
                email: self.email,
                firstName: self.firstName,
                lastName: self.lastName,
                account: account
            )
            return user
        } catch {
            return MainUserStoreModel()
        }
    }
    
    func toStore() -> UserStoreModel {
        return UserStoreModel(
            recordName: self.recordName ?? "",
            username: self.username,
            email: self.email,
            firstName: self.firstName,
            lastName: self.lastName
        )
    }
}
