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
let mainUserDB = CKMainUserManager()
let userDB = CKUserManager()
let accountDB = CKAccountManager()
let evaluationDB = CKEvaluationManager()
let entryDB = CKEntryManager()
let taskDB = CKTaskManager()
let paymentDB = CKPaymentManager()

// MARK: - settings
let usernameSettings = UsernameSettingModel()
let taskSettings = TaskSettingsModel()
