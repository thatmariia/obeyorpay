//
//  CKMainUserManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit


class CKMainUserManager: CKManager {
    
    // MARK: - record modifications
    
    func fromMainUserToCKRecord(from user: AnyObject, to record: CKRecord) -> CKRecord {
        let user = user as! UserCKModel
        record[UserCKKeys.uid.rawValue]          = user.uid          as CKRecordValue
        record[UserCKKeys.username.rawValue]     = user.username     as CKRecordValue
        record[UserCKKeys.email.rawValue]        = user.email        as CKRecordValue
        record[UserCKKeys.firstName.rawValue]    = user.firstName    as CKRecordValue
        record[UserCKKeys.lastName.rawValue]     = user.lastName     as CKRecordValue
        record[UserCKKeys.accountRef.rawValue]   = user.accountRef   as CKRecordValue
        return record
    }
    
    func fromCKRecordToMainUser(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        let uid           = record[UserCKKeys.uid.rawValue]        as? String
        let username      = record[UserCKKeys.username.rawValue]   as? String
        let email         = record[UserCKKeys.email.rawValue]      as? String
        let firstName     = record[UserCKKeys.firstName.rawValue]  as? String
        let lastName      = record[UserCKKeys.lastName.rawValue]   as? String
        let accountRef    = record[UserCKKeys.accountRef.rawValue] as? String
        let user = UserCKModel(
            recordName: recordName,
            uid: uid!,
            username: username!,
            email: email!,
            firstName: firstName!,
            lastName: lastName!,
            accountRef: accountRef!
        )
        return user
    }
    
    // MARK: - database actions
    
    func addMainUser(user: MainUserStoreModel) async throws -> MainUserStoreModel {
        let user = user.toCK()
        do {
            let user = try await addObject(of: .user, object: user, fromObjectToCKRecord: fromMainUserToCKRecord, fromCKRecordToObject: fromCKRecordToMainUser) as! UserCKModel
            return await user.toMainStore()
        } catch let err {
            throw err
        }
    }

    func changeMainUser(with recordName: String, to user: MainUserStoreModel) async throws -> MainUserStoreModel {
        let user = user.toCK()
        do {
            // fetch record with id
            var record = try await fetchRecord(with: CKRecord.ID(recordName: recordName))
            // make changes
            record = fromMainUserToCKRecord(from: user, to: record)
            // save changes
            let user = try await saveObject(of: record, fromCKRecordToObject: fromCKRecordToMainUser) as! UserCKModel
            return await user.toMainStore()
        } catch let err {
            throw err
        }
    }
    
    
    // TODO:: move?
    func countUsers(with username: String) async throws -> Int {
        let predicate = NSPredicate(format: "%K == %@", UserCKKeys.username.rawValue, username)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToMainUser)
            return users.count
        } catch let err {
            throw err
        }
    }
    
    func queryMainUser(withKey key: UserCKKeys, _ operation: CKQueryOperation, to value: String) async throws -> MainUserStoreModel {
        let predicate = NSPredicate(format: "%K \(operation.rawValue) %@", key.rawValue, value)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToMainUser) as! [UserCKModel]
            if users.count == 0 {
                throw CKError.noRecords
            }
            let user = users.first!
            return await user.toMainStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchMainUser(with recordName: String) async throws -> MainUserStoreModel {
        do {
            let user = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToMainUser) as! UserCKModel
            return await user.toMainStore()
        } catch let err {
            throw err
        }
    }
} 
