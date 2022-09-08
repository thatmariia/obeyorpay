//
//  CKEntryManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import Foundation
import CloudKit


class CKEntryManager: CKManager {
    
    // MARK: - record modifications
    
    func fromEntryToCKRecord(from entry: AnyObject, to record: CKRecord) -> CKRecord {
        let entry = entry as! EntryCKModel
        record[EntryCKKeys.userRef.rawValue]        = entry.userRef         as CKRecordValue
        record[EntryCKKeys.taskRef.rawValue]        = entry.taskRef         as CKRecordValue
        record[EntryCKKeys.timestamp.rawValue]      = entry.timestamp       as CKRecordValue
        record[EntryCKKeys.evaluationRef.rawValue]  = entry.evaluationRef   as CKRecordValue
        return record
    }
    
    func fromCKRecordToEntry(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        guard let userRef = record[EntryCKKeys.userRef.rawValue] as? String else { return nil }
        guard let taskRef = record[EntryCKKeys.taskRef.rawValue] as? String else { return nil }
        guard let timestamp = record[EntryCKKeys.timestamp.rawValue] as? Date else { return nil }
        guard let evaluationRef = record[EntryCKKeys.evaluationRef.rawValue] as? String else { return nil }
        let entry = EntryCKModel(
            recordName: recordName,
            userRef: userRef,
            taskRef: taskRef,
            timestamp: timestamp,
            evaluationRef: evaluationRef
        )
        return entry
    }
    
    // MARK: - database actions
    
    func fetchEntries(with recordNames: [String]) async throws -> [EntryStoreModel] {
        do {
            let entries = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToEntry) as! [EntryCKModel]
            return entries.map { $0.toStore() }
        } catch let err {
            throw err
        }
    }
}
