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
        guard let username      = record[UserCKKeys.username.rawValue]   as? String else { return nil }
        guard let email         = record[UserCKKeys.email.rawValue]      as? String else { return nil }
        guard let firstName     = record[UserCKKeys.firstName.rawValue]  as? String else { return nil }
        guard let lastName      = record[UserCKKeys.lastName.rawValue]   as? String else { return nil }
        let user = UserCKModel(
            recordName: recordName,
            username: username,
            email: email,
            firstName: firstName,
            lastName: lastName
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
}
