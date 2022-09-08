//
//  UserStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import Foundation


class UserStoreModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: UserStoreModel, rhs: UserStoreModel) -> Bool {
        return (lhs.recordName == rhs.recordName) && (lhs.uid == rhs.uid) && (lhs.username == rhs.username) && (lhs.email == rhs.email) && (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName) && (lhs.account == rhs.account)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(uid)
        hasher.combine(username)
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(account)
    }
    
    var recordName: String?
    var uid: String
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var account: AccountStoreModel
    
    init() {
        self.recordName = nil
        self.uid = ""
        self.username = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.account = AccountStoreModel()
    }
    
    init(
        recordName: String,
        uid: String,
        username: String,
        email: String,
        firstName: String,
        lastName: String,
        account: AccountStoreModel
    ) {
        self.recordName = recordName
        self.uid = uid
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.account = account
    }
    
    init(
        uid: String,
        username: String,
        email: String,
        firstName: String,
        lastName: String,
        account: AccountStoreModel
    ) {
        self.recordName = nil
        self.uid = uid
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.account = account
    }
    
    func toCK() -> UserCKModel {
        return UserCKModel(
            recordName: self.recordName ?? "",
            uid: self.uid,
            username: self.username,
            email: self.email,
            firstName: self.firstName,
            lastName: self.lastName,
            accountRef: self.account.recordName ?? ""
        )
    }
}
