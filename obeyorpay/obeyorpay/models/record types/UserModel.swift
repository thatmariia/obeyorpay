//
//  UserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


enum UserModelKeys: String, CaseIterable {
    case uid = "accountId"
    case username = "username"
    case email = "email"
    case firstName = "firstName"
    case lastName = "lastName"
}


class UserModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return (lhs.uid == rhs.uid) && (lhs.username == rhs.username) && (lhs.email == rhs.email) && (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
        hasher.combine(username)
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
    }
    
    var uid: String
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    
    init() {
        self.uid = ""
        self.username = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
    }
    
}
