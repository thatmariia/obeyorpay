//
//  CKUserManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit


class CKUserManager: CKManager {
    
    // MARK: - record modifications
    
    func fromUserToCKRecord(from user: AnyObject, to record: CKRecord) -> CKRecord {
        let user = user as! UserCKModel
        record[UserCKKeys.uid.rawValue]          = user.uid          as CKRecordValue
        record[UserCKKeys.username.rawValue]     = user.username     as CKRecordValue
        record[UserCKKeys.email.rawValue]        = user.email        as CKRecordValue
        record[UserCKKeys.firstName.rawValue]    = user.firstName    as CKRecordValue
        record[UserCKKeys.lastName.rawValue]     = user.lastName     as CKRecordValue
        record[UserCKKeys.accountRef.rawValue]   = user.accountRef   as CKRecordValue
        return record
    }
    
    func fromCKRecordToUser(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        guard let uid           = record[UserCKKeys.uid.rawValue]        as? String else { return nil }
        guard let username      = record[UserCKKeys.username.rawValue]   as? String else { return nil }
        guard let email         = record[UserCKKeys.email.rawValue]      as? String else { return nil }
        guard let firstName     = record[UserCKKeys.firstName.rawValue]  as? String else { return nil }
        guard let lastName      = record[UserCKKeys.lastName.rawValue]   as? String else { return nil }
        guard let accountRef    = record[UserCKKeys.accountRef.rawValue] as? String else { return nil }
        let user = UserCKModel(
            recordName: recordName,
            uid: uid,
            username: username,
            email: email,
            firstName: firstName,
            lastName: lastName,
            accountRef: accountRef
        )
        return user
    }
    
    // MARK: - database actions
    
    func addUser(user: UserStoreModel) async throws -> UserStoreModel {
        let user = user.toCK()
        do {
            let user = try await addObject(of: .user, object: user, fromObjectToCKRecord: fromUserToCKRecord, fromCKRecordToObject: fromCKRecordToUser) as! UserCKModel
            return await user.toStore()
        } catch let err {
            throw err
        }
    }
    
    // TODO:: move to parent
    func changeUser(with recordName: String, to user: UserStoreModel) async throws -> UserStoreModel {
        let user = user.toCK()
        do {
            // fetch record with id
            var record = try await fetchRecord(with: CKRecord.ID(recordName: recordName))
            // change username in the record
            record = fromUserToCKRecord(from: user, to: record)
            // save changes
            let user = try await saveObject(of: record, fromCKRecordToObject: fromCKRecordToUser) as! UserCKModel
            return await user.toStore()
        } catch let err {
            throw err
        }
    }
    
    func countUsers(with username: String) async throws -> Int {
        let predicate = NSPredicate(format: "%K == %@", UserCKKeys.username.rawValue, username)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToUser)
            return users.count
        } catch let err {
            throw err
        }
    }
    
    func queryUser(withKey key: UserCKKeys, _ operation: CKQueryOperation, to value: String) async throws -> UserStoreModel {
        let predicate = NSPredicate(format: "%K \(operation.rawValue) %@", key.rawValue, value)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToUser) as! [UserCKModel]
            if users.count == 0 {
                throw CKError.noRecords
            }
            let user = users.first!
            return await user.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchUser(with recordName: String) async throws -> UserStoreModel {
        do {
            let user = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToUser) as! UserCKModel
            return await user.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchUsers(with recordNames: [String]) async throws -> [UserStoreModel] {
        do {
            let users = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToUser) as! [UserCKModel]
            return await users.asyncMap { await $0.toStore() }
        } catch let err {
            throw err
        }
    }
} 
