//
//  UserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation


class UserModel: ObservableObject {
    
    @Published var uid: String
    @Published var username: String
    @Published var email: String
    @Published var firstName: String
    @Published var lastName: String
    
    
    init() {
        self.uid = ""
        self.username = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
    }
}
