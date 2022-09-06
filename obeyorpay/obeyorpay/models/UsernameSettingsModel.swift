//
//  UsernameSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


struct UsernameSettingModel {
    
    var usernameAllowedSymbols = lowercaseLetters + uppercaseLetters + "_"
    var usernameMaxLength = 30
    var usernameDefaultLength = 16
    
    func getDefaultUsername() -> String {
        return getRandomUsername()
    }
    
    func getRandomUsername() -> String {
        return String((0..<self.usernameDefaultLength).map{ _ in self.usernameAllowedSymbols.randomElement()! })
    }
    
    func isCorrectUsername(username: String) -> Bool {
        // TODO
        return true
    }
    
    
}
