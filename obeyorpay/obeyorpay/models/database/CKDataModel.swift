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
    
    func fetchRecord(with recordID: CKRecord.ID) async throws -> CKRecord {
        
        do {
            let record = try await publicDB.record(for: recordID)
            return record
        } catch let err {
            throw err
        }
    }
    
    func saveRecord(record: CKRecord) async throws -> Bool {
        
        do {
            let _ = try await publicDB.save(record)
            return true
        } catch let err {
            throw err
        }
    }
    
}
