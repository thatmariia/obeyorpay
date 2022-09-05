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
    @Published var first_name: String
    @Published var last_name: String
    
    
    init() {
        self.uid = ""
        self.username = ""
        self.email = ""
        self.first_name = ""
        self.last_name = ""
    }
}
