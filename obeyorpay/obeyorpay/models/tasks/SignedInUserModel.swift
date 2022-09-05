//
//  SignedInUserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


class SignedInUserModel: ObservableObject {
    
    @Published var uid: String
    
    init() {
        self.uid = ""
    }
}
