//
//  CKDataModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit


enum CKDataRecordTypes: String, CaseIterable {
    case user = "User"
    case account = "Account"
    case entry = "Entry"
    case evaluation = "Evaluation"
    case payment = "Payment"
    case task = "Task"
}

enum CKHelperError: Error {
    case recordFailure
    case recordIDFailure
    case castFailure
    case cursorFailure
}

class CKDataModel {
    
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    init() {
      container = CKContainer.default()
      publicDB = container.publicCloudDatabase
      privateDB = container.privateCloudDatabase
    }
    
}
