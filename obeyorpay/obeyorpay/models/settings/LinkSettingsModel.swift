//
//  LinkSettings.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import Foundation


class LinkSettingsModel {
    
    func isCorrectLink(link: String) -> CorrectnessComment {
        // TODO: actually check if the link is correct
        return CorrectnessComment(isCorrect: true, note: "")
    }
    
    func updateLink(link: String, signedInUser: SignedInUserModel) {
        userCD.clearCDEntity()
        userCD.addUser(with: signedInUser.user.uid, paymentLink: link)
    }
}
