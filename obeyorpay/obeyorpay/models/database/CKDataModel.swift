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

enum CKQueryOperation: String {
    case equal = "=="
}

enum CKHelperError: Error {
    case recordFailure
    case recordIDFailure
    case castFailure
    case cursorFailure
    
    case noRecords
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
    
    
    func queryRecords(in recordType: CKDataRecordTypes, with predicate: NSPredicate, fromCKRecordToObject: (CKRecord) -> AnyObject?) async throws -> [AnyObject] {
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let (results, _) = try await publicDB.records(matching: query)
            var retrievedObjects: [AnyObject] = []
            
            for result in results {
                switch result.1 {
                case .success(let record):
                    let object = fromCKRecordToObject(record)
                    if object != nil {
                        retrievedObjects.append(object!)
                    }
                    break
                case .failure(let err):
                    throw err
                }
            }
            
            return retrievedObjects
        } catch let err {
            throw err
        }
    }
    
    
    func saveRecord(of record: CKRecord, fromCKRecordToObject: (CKRecord) -> AnyObject?) async throws -> AnyObject {
        do {
            try await publicDB.save(record)
            let data = fromCKRecordToObject(record)
            if data == nil { throw CKHelperError.castFailure }
            return data!
        } catch let err {
            throw err
        }
    }
    
    func addRecord(of recordType: CKDataRecordTypes, with data: AnyObject, fromObjectToCKRecord: (AnyObject, CKRecord) -> CKRecord, fromCKRecordToObject: (CKRecord) -> AnyObject?) async throws -> AnyObject {
        let record = fromObjectToCKRecord(data, CKRecord(recordType: recordType.rawValue))
        
        do {
            let data = try await saveRecord(of: record, fromCKRecordToObject: fromCKRecordToObject)
            return data
        } catch let err {
            throw err
        }
    }
    
    
}
