//
//  LinkSettings.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import Foundation

enum LinkNotes: String {
    case invalidLink = "The entered link is invalid"
}


class LinkSettingsModel {
    
    let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
    
    func isCorrectLink(link: String) -> CorrectnessComment {
        // TODO: actually check if the link is correct
        
        if NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: link) {
            return CorrectnessComment(isCorrect: true, note: "")
        }
        
        return CorrectnessComment(isCorrect: false, note: LinkNotes.invalidLink.rawValue)
    }
    
    func updateLink(link: String, signedInUser: SignedInUserModel) {
        userCD.clearCDEntity()
        userCD.addUser(with: signedInUser.user.uid, paymentLink: link)
    }
}
