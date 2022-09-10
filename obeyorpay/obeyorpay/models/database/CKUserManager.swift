//
//  CKUserManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 09/09/2022.
//

import Foundation
import CloudKit


class CKUserManager: CKManager {
    
    // MARK: - record modifications

    func fromCKRecordToUser(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        let username      = record[UserCKKeys.username.rawValue]   as? String
        let email         = record[UserCKKeys.email.rawValue]      as? String
        let firstName     = record[UserCKKeys.firstName.rawValue]  as? String
        let lastName      = record[UserCKKeys.lastName.rawValue]   as? String
        let user = UserCKModel(
            recordName: recordName,
            username: username!,
            email: email!,
            firstName: firstName!,
            lastName: lastName!
        )
        return user
    }
    
    // MARK: - database actions
    
    func fetchUser(with recordName: String) async throws -> UserStoreModel {
        do {
            let user = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToUser) as! UserCKModel
            return user.toStore()
        } catch let err {
            throw err
        }
    }

    func fetchUsers(with recordNames: [String]) async throws -> [UserStoreModel] {
        do {
            let users = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToUser) as! [UserCKModel]
            return await users.asyncMap { $0.toStore() }
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
    
    func queryUsers(withKey key: UserCKKeys, _ operation: CKQueryOperation, to value: String) async throws -> [UserStoreModel] {
        let predicate = NSPredicate(format: "%K \(operation.rawValue) %@", key.rawValue, value)
        
        do {
            let users = try await queryObjects(of: .user, with: predicate, fromCKRecordToObject: fromCKRecordToUser) as! [UserCKModel]
            return await users.asyncMap { $0.toStore() }
        } catch let err {
            throw err
        }
    }
}
