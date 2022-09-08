//
//  UserCKModel.swift
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


class UserCKModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: UserCKModel, rhs: UserCKModel) -> Bool {
        return (lhs.recordName == rhs.recordName) && (lhs.uid == rhs.uid) && (lhs.username == rhs.username) && (lhs.email == rhs.email) && (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName) && (lhs.accountRef == rhs.accountRef)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(uid)
        hasher.combine(username)
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(accountRef)
    }
    
    var recordName: String?
    var uid: String
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var accountRef: String
    
    
    init(recordName: String, uid: String, username: String, email: String, firstName: String, lastName: String, accountRef: String) {
        self.recordName = recordName
        self.uid = uid
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.accountRef = accountRef
    }
    
    init() {
        self.recordName = nil
        self.uid = ""
        self.username = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.accountRef = ""
    }
    
    func toStore() -> UserStoreModel {
//        do {
        let account = AccountStoreModel()
        account.recordName = accountRef
            let user = UserStoreModel(
                recordName: recordName ?? "",
                uid: uid,
                username: username,
                email: email,
                firstName: firstName,
                lastName: lastName,
                account: account
            )
            return user
//        } catch let err {
//
//        }
    }
}
