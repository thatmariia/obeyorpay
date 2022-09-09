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
        return (lhs.recordName == rhs.recordName) &&
        (lhs.username == rhs.username) &&
        (lhs.email == rhs.email) &&
        (lhs.firstName == rhs.firstName) &&
        (lhs.lastName == rhs.lastName)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(username)
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
    }
    
    var recordName: String?
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    
    init() {
        self.recordName = nil
        self.username = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
    }
    
    init(
        recordName: String,
        username: String,
        email: String,
        firstName: String,
        lastName: String
    ) {
        self.recordName = recordName
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}
