//
//  UsernameSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


enum UsernameNotes: String {
    case allowedCharacters = "Username can only contain latin lowercase letters, digits, and underscores (_)"
    case minLength = "Username should contain at least 2 characters"
    case maxLength = "Username should contain at most 30 characters"
    case alreadyExists = "Username already exists"
}


class UsernameSettingModel {
    
    var usernameallowedCharacters = lowercaseLetters + digits + "_"
    var usernameMinLength = 2
    var usernameMaxLength = 30
    var usernameDefaultLength = 16
    
    // supporting
    private var noUsersWithUsername = true
    private var updatedUser = UserStoreModel()
    
    func getDefaultUsername() -> String {
        return getRandomUsername()
    }
    
    func getRandomUsername() -> String {
        return String((0..<self.usernameDefaultLength).map{ _ in self.usernameallowedCharacters.randomElement()! })
    }

    func updateUser(signedInUser: SignedInUserModel, with newUsername: String) async throws {
        self.updatedUser = signedInUser.user
        self.updatedUser.username = newUsername
        do {
            self.updatedUser = try await userDB.changeUser(with: signedInUser.user.recordName!, to: self.updatedUser)
        } catch { }
        DispatchQueue.main.async {
            signedInUser.user = self.updatedUser
            self.updatedUser = UserStoreModel() // reset
        }
    }
    
    func isCorrectUsername(currUsername: String, newUsername: String) async throws -> CorrectnessComment {
        // no change
        if currUsername == newUsername {
            return CorrectnessComment(isCorrect: true, note: nil)
        }
        
        // allower characters - not met
        for character in newUsername {
            if !self.usernameallowedCharacters.contains(character) {
                return CorrectnessComment(isCorrect: false, note: UsernameNotes.allowedCharacters.rawValue)
            }
        }
        
        // min length - not met
        if newUsername.count < self.usernameMinLength {
            return CorrectnessComment(isCorrect: false, note: UsernameNotes.minLength.rawValue)
        }
        
        // max length - not met
        if newUsername.count > self.usernameMaxLength {
            return CorrectnessComment(isCorrect: false, note: UsernameNotes.maxLength.rawValue)
        }
        
        // already exists
        self.noUsersWithUsername = true
        do {
            let nrUsers = try await userDB.countUsers(with: newUsername)
            self.noUsersWithUsername = nrUsers == 0
        } catch { }
        if !self.noUsersWithUsername {
            return CorrectnessComment(isCorrect: false, note: UsernameNotes.alreadyExists.rawValue)
        }
        
        // all good
        return CorrectnessComment(isCorrect: true, note: nil)
    }
}
