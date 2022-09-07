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
    
    func addUser(user: UserCKModel) async throws -> UserCKModel {
        
        do {
            let user = try await addObject(of: .user, object: user, fromObjectToCKRecord: fromUserToCKRecord, fromCKRecordToObject: fromCKRecordToUser) as! UserCKModel
            return user
        } catch let err {
            throw err
        }
    }
    
    func changeUser(with recordName: String, to user: UserCKModel) async throws -> UserCKModel {
        do {
            // fetch record with id
            var record = try await fetchRecord(with: CKRecord.ID(recordName: recordName))
            // change username in the record
            record = fromUserToCKRecord(from: user, to: record)
            // save changes
            let user = try await saveObject(of: record, fromCKRecordToObject: fromCKRecordToUser)
            return user as! UserCKModel
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
    
    func queryUser(withKey key: UserCKKeys, _ operation: CKQueryOperation, to value: String) async throws -> UserCKModel {
        let predicate = NSPredicate(format: "%K \(operation.rawValue) %@", key.rawValue, value)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToUser) as! [UserCKModel]
            if users.count == 0 {
                throw CKError.noRecords
            }
            return users.first!
        } catch let err {
            throw err
        }
    }
    
    func fetchUser(with recordName: String) async throws -> UserCKModel {
        do {
            let user = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToUser)
            return user as! UserCKModel
        } catch let err {
            throw err
        }
    }
}
