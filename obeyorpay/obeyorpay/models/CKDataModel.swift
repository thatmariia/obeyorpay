//
//  CKDataModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit

enum CKDataRecordTypes: String, CaseIterable {
    case user = "Users"
    case account = "Account"
    case entry = "Entry"
    case evaluation = "Evaluation"
    case payment = "Payment"
    case task = "Task"
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
