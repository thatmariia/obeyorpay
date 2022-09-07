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
    private var updatedUser = UserModel()
    
    func getDefaultUsername() -> String {
        return getRandomUsername()
    }
    
    func getRandomUsername() -> String {
        return String((0..<self.usernameDefaultLength).map{ _ in self.usernameallowedCharacters.randomElement()! })
    }

    func updateUser(signedInUser: SignedInUserModel, with newUsername: String) async throws {
        self.updatedUser = signedInUser.user
        do {
            self.updatedUser = try await userDB.editUserRecord(with: signedInUser.user.recordID!, edit: newUsername)
        } catch { }
        DispatchQueue.main.async {
            signedInUser.user = self.updatedUser
            self.updatedUser = UserModel()
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
