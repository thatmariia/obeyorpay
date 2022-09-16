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
        return record
    }
    
    func fromCKRecordToEntry(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        let userRef         = record[EntryCKKeys.userRef.rawValue]          as? String
        let taskRef         = record[EntryCKKeys.taskRef.rawValue]          as? String
        let timestamp       = record[EntryCKKeys.timestamp.rawValue]        as? Date
        let entry = EntryCKModel(
            recordName: recordName,
            userRef: userRef!,
            taskRef: taskRef!,
            timestamp: timestamp!
        )
        return entry
    }
    
    // MARK: - database actions
    
    func fetchEntry(with recordName: String) async throws -> EntryStoreModel {
        do {
            let entry = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToEntry) as! EntryCKModel
            return await entry.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchEntries(with recordNames: [String]) async throws -> [EntryStoreModel] {
        do {
            let entries = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToEntry) as! [EntryCKModel]
            return await entries.asyncMap { await $0.toStore() }
        } catch let err {
            throw err
        }
    }
    
    func addEntry(entry: EntryStoreModel) async throws -> EntryStoreModel {
        let entry = entry.toCK()
        do {
            let entry = try await addObject(of: .entry, object: entry, fromObjectToCKRecord: fromEntryToCKRecord, fromCKRecordToObject: fromCKRecordToEntry) as! EntryCKModel
            return await entry.toStore()
        } catch let err {
            throw err
        }
    }
    
    func deleteEntry(with recordName: String) async throws {
        do {
            try await deleteObject(with: CKRecord.ID(recordName: recordName))
        } catch let err {
            throw err
        }
    }
}
