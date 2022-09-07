//
//  CKDataUserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit


class CKDataUserModel: CKDataModel {
    
    var userRecordType = CKDataRecordType.user.rawValue
    
    // MARK: - record modifications
    
    func fromUserToCKRecord(from user: AnyObject, to record: CKRecord) -> CKRecord {
        let user = user as! UserModel
        record[UserModelKeys.uid.rawValue]          = user.uid          as CKRecordValue
        record[UserModelKeys.username.rawValue]     = user.username     as CKRecordValue
        record[UserModelKeys.email.rawValue]        = user.email        as CKRecordValue
        record[UserModelKeys.firstName.rawValue]    = user.firstName    as CKRecordValue
        record[UserModelKeys.lastName.rawValue]     = user.lastName     as CKRecordValue
        return record
    }
    
    func fromCKRecordToUser(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        guard let uid       = record[UserModelKeys.uid.rawValue]        as? String else { return nil }
        guard let username  = record[UserModelKeys.username.rawValue]   as? String else { return nil }
        guard let email     = record[UserModelKeys.email.rawValue]      as? String else { return nil }
        guard let firstName = record[UserModelKeys.firstName.rawValue]  as? String else { return nil }
        guard let lastName  = record[UserModelKeys.lastName.rawValue]   as? String else { return nil }
        let user = UserModel(
            recordName: recordName, uid: uid, username: username, email: email, firstName: firstName, lastName: lastName
        )
        return user
    }
    
    // MARK: - database actions
    
    func addUser(user: UserModel) async throws -> UserModel {
        
        do {
            let user = try await addObject(of: .user, with: user, fromObjectToCKRecord: fromUserToCKRecord, fromCKRecordToObject: fromCKRecordToUser) as! UserModel
            return user
        } catch let err {
            throw err
        }
    }
    
    func changeUser(with recordName: String, to user: UserModel) async throws -> UserModel {
        do {
            // fetch record with id
            var record = try await fetchRecord(with: CKRecord.ID(recordName: recordName))
            // change username in the record
            record = fromUserToCKRecord(from: user, to: record)
            // save changes
            let user = try await saveObject(of: record, fromCKRecordToObject: fromCKRecordToUser)
            return user as! UserModel
        } catch let err {
            throw err
        }
    }
    
    func countUsers(with username: String) async throws -> Int {
        let predicate = NSPredicate(format: "%K == %@", UserModelKeys.username.rawValue, username)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToUser)
            return users.count
        } catch let err {
            throw err
        }
    }
    
    func queryUser(withKey key: UserModelKeys, _ operation: CKQueryOperation, to value: String) async throws -> UserModel {
        let predicate = NSPredicate(format: "%K \(operation.rawValue) %@", key.rawValue, value)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToUser) as! [UserModel]
            if users.count == 0 {
                throw CKError.noRecords
            }
            return users.first!
        } catch let err {
            throw err
        }
    }
    
    func fetchUser(with recordName: String) async throws -> UserModel {
        do {
            let user = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToUser)
            return user as! UserModel
        } catch let err {
            throw err
        }
    }
}
