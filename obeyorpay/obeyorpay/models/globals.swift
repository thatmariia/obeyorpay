//
//  globals.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let digits = "0123456789"


// MARK: - auth
let authentificator = SignInAppleModel()

// MARK: - core data
let userCD = CDDataUserModel()

// MARK: - database models
let globalDB = CKManager()
let mainUserDB = CKMainUserManager()
let userDB = CKUserManager()
let accountDB = CKAccountManager()
let evaluationDB = CKEvaluationManager()
let entryDB = CKEntryManager()
let taskDB = CKTaskManager()
let paymentDB = CKPaymentManager()

let subscriptionDB = CKSubscriptionsManager()
let subscriptionIDs = CKSubscriptionsID()

// MARK: - settings
let mainSettings = MainSettingsModel()
let usernameSettings = UsernameSettingModel()
let taskSettings = TaskSettingsModel()

// MARK: - UI stuff
let theme = AppTheme()

// MARK: - dates and times
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM yyyy"
    return formatter
}()
let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()
let fullDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM yyyy, HH:mm"
    return formatter
}()
