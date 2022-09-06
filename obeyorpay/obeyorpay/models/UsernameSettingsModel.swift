//
//  UsernameSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


struct UsernameComment {
    var isCorrect: Bool
    var note: String?
    
    init(isCorrect: Bool, note: String?) {
        self.isCorrect = isCorrect
        self.note = note
    }
}

enum UsernameNotes: String {
    case allowedCharacters = "Username can only contain latin letters, digits, and underscores (_)"
    case minLength = "Username should contain at least 2 symbols"
    case maxLength = "Username should contain at most 30 symbols"
    case alreadyExists = "Username already exists"
}


struct UsernameSettingModel {
    
    var usernameallowedCharacters = lowercaseLetters + uppercaseLetters + "_"
    var usernameMinLength = 2
    var usernameMaxLength = 30
    var usernameDefaultLength = 16
    
    func getDefaultUsername() -> String {
        return getRandomUsername()
    }
    
    func getRandomUsername() -> String {
        return String((0..<self.usernameDefaultLength).map{ _ in self.usernameallowedCharacters.randomElement()! })
    }
    
    func updateUser(user: UserModel, with newUsername: String) -> UserModel {
        var updatedUser = user
//        userDB.editUserRecord(with: user.recordID!, edit: newUsername) { result in
//            switch result {
//            case .success(let user):
//                DispatchQueue.main.async {
//                    updatedUser = user
//                }
//                break
//            case .failure(let err):
//                print(err.localizedDescription)
//                break
//            }
//        }
        return updatedUser
    }
    
    func isCorrectUsername(currUsername: String, newUsername: String) -> UsernameComment {
        // no change
        if currUsername == newUsername {
            return UsernameComment(isCorrect: true, note: nil)
        }
        
        // allower characters - not met
        for character in newUsername {
            if !self.usernameallowedCharacters.contains(character) {
                return UsernameComment(isCorrect: false, note: UsernameNotes.allowedCharacters.rawValue)
            }
        }
        
        // min length - not met
        if newUsername.count < self.usernameMinLength {
            return UsernameComment(isCorrect: false, note: UsernameNotes.minLength.rawValue)
        }
        
        // max length - not met
        if newUsername.count > self.usernameMaxLength {
            return UsernameComment(isCorrect: false, note: UsernameNotes.maxLength.rawValue)
        }
        
        // already exists
        var noUsersWithUsername: Bool = false
//        DispatchQueue.main.sync {
//            userDB.fetchUserRecords(with: newUsername) { result in
//                switch result {
//                case .success(let nrUsers):
//                    noUsersWithUsername = nrUsers == 0
//                    print("*********", nrUsers, noUsersWithUsername)
//                    break
//                case .failure(let err):
//                    print(err.localizedDescription)
//                    break
//                }
//            }
//        }
        if !noUsersWithUsername {
            print("********* returning", noUsersWithUsername)
            return UsernameComment(isCorrect: false, note: UsernameNotes.alreadyExists.rawValue)
        }
        
        return UsernameComment(isCorrect: true, note: nil)
    }
}
