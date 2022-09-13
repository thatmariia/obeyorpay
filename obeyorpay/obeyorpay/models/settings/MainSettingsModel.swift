//
//  MainSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import Foundation


class MainSettingsModel {
    
    func refreshUserData(signedInUser: SignedInUserModel) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
                    let user = try await mainUserDB.fetchMainUser(with: signedInUser.user.recordName!)
                    signedInUser.user = user
                } catch let err {
                    throw err
                }
            }
        }
    }
}
