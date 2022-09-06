//
//  SignInViewModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import SwiftUI


class SignInViewModel {
    
    func signin(from view: LoginView) {
        SignInAppleModel(parent: view).didTapButton()
    }
    
}
