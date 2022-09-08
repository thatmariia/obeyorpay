//
//  CKAccountManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit


class CKAccountManager: CKManager {
    
    // MARK: - record modifications
    
    func fromAccountToCKRecord(from account: AnyObject, to record: CKRecord) -> CKRecord {
        let account = account as! AccountCKModel
        record[AccountCKKeys.personalTasksRefs.rawValue]        = account.personalTasksRefs         as CKRecordValue
        record[AccountCKKeys.jointTasksRefs.rawValue]           = account.jointTasksRefs            as CKRecordValue
        record[AccountCKKeys.sharedTasksRefs.rawValue]          = account.sharedTasksRefs           as CKRecordValue
        record[AccountCKKeys.paymentsRefs.rawValue]             = account.paymentsRefs              as CKRecordValue
        record[AccountCKKeys.entriesRefs.rawValue]              = account.entriesRefs               as CKRecordValue
        record[AccountCKKeys.evaluationsRefs.rawValue]          = account.evaluationsRefs           as CKRecordValue
        record[AccountCKKeys.jointInvitedTasksRefs.rawValue]    = account.jointInvitedTasksRefs     as CKRecordValue
        record[AccountCKKeys.sharedInvitedTasksRefs.rawValue]   = account.sharedInvitedTasksRefs    as CKRecordValue
        return record
    }
    
    func fromCKRecordToAccount(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        guard let personalTasksRefs         = record[AccountCKKeys.personalTasksRefs.rawValue]      as? [String] else { return nil }
        guard let jointTasksRefs            = record[AccountCKKeys.jointTasksRefs.rawValue]         as? [String] else { return nil }
        guard let sharedTasksRefs           = record[AccountCKKeys.sharedTasksRefs.rawValue]        as? [String] else { return nil }
        guard let paymentsRefs              = record[AccountCKKeys.paymentsRefs.rawValue]           as? [String] else { return nil }
        guard let entriesRefs               = record[AccountCKKeys.entriesRefs.rawValue]            as? [String] else { return nil }
        guard let evaluationsRefs           = record[AccountCKKeys.evaluationsRefs.rawValue]        as? [String] else { return nil }
        guard let jointInvitedTasksRefs     = record[AccountCKKeys.jointInvitedTasksRefs.rawValue]  as? [String] else { return nil }
        guard let sharedInvitedTasksRefs    = record[AccountCKKeys.sharedInvitedTasksRefs.rawValue] as? [String] else { return nil }
        let account = AccountCKModel(
            recordName: recordName,
            personalTasksRefs: personalTasksRefs,
            jointTasksRefs: jointTasksRefs,
            sharedTasksRefs: sharedTasksRefs,
            paymentsRefs: paymentsRefs,
            entriesRefs: entriesRefs,
            evaluationsRefs: evaluationsRefs,
            jointInvitedTasksRefs: jointInvitedTasksRefs,
            sharedInvitedTasksRefs: sharedInvitedTasksRefs
        )
        return account
    }
    
    // MARK: - database actions
    
    func addAccount(account: AccountStoreModel) async throws -> AccountStoreModel {
        let account = account.toCK()
        do {
            let account = try await addObject(of: .account, object: account, fromObjectToCKRecord: fromAccountToCKRecord, fromCKRecordToObject: fromCKRecordToAccount) as! AccountCKModel
            return account.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchAccount(with recordName: String) async throws -> AccountStoreModel {
        do {
            let account = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToAccount) as! AccountCKModel
            return account.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchAccounts(with recordNames: [String]) async throws -> [AccountStoreModel] {
        do {
            let accounts = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToAccount) as! [AccountCKModel]
            return accounts.map { $0.toStore() }
        } catch let err {
            throw err
        }
    }
    
}
