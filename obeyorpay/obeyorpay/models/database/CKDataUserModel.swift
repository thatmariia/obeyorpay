//
//  CKDataUserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CloudKit


class CKDataUserModel: CKDataModel {
    
    var userRecordType = CKDataRecordTypes.user.rawValue
    
    // MARK: - record modifications
    
    func wrapUserRecord(into itemRecord: CKRecord, with user: UserModel) -> CKRecord {
        itemRecord[UserModelKeys.uid.rawValue]          = user.uid          as CKRecordValue
        itemRecord[UserModelKeys.username.rawValue]     = user.username     as CKRecordValue
        itemRecord[UserModelKeys.email.rawValue]        = user.email        as CKRecordValue
        itemRecord[UserModelKeys.firstName.rawValue]    = user.firstName    as CKRecordValue
        itemRecord[UserModelKeys.lastName.rawValue]     = user.lastName     as CKRecordValue
        return itemRecord
    }
    
    func unwrapUserRecord(from record: CKRecord) -> UserModel? {
        let recordID = record.recordID
        guard let uid       = record[UserModelKeys.uid.rawValue]        as? String else { return nil }
        guard let username  = record[UserModelKeys.username.rawValue]   as? String else { return nil }
        guard let email     = record[UserModelKeys.email.rawValue]      as? String else { return nil }
        guard let firstName = record[UserModelKeys.firstName.rawValue]  as? String else { return nil }
        guard let lastName  = record[UserModelKeys.lastName.rawValue]   as? String else { return nil }
        let user = UserModel(
            recordID: recordID, uid: uid, username: username, email: email, firstName: firstName, lastName: lastName
        )
        return user
    }
    
    // MARK: - supporting database actions
    
    func saveUserRecord(record: CKRecord) async throws -> UserModel {
        
        do {
            let _ = try await saveRecord(record: record)

            let user = self.unwrapUserRecord(from: record)
            if user == nil {
                throw CKHelperError.castFailure
            }
            return user!
            
        } catch let err {
            throw err
        }
    }
    
    // MARK: - database actions
    
    func addUserRecord(of user: UserModel) async throws -> UserModel {
        
        // create record
        let record = wrapUserRecord(
            into: CKRecord(recordType: userRecordType),
            with: user
        )
        
        // save record
        do {
            let user = try await saveUserRecord(record: record)
            return user
        } catch let err {
            throw err
        }
    }
    
    func fetchUserRecords(with username: String) async throws -> Int {
        let predicate = NSPredicate(format: "%K == %@", UserModelKeys.username.rawValue, username)
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        
        do {
            let (returnedUsers, _) = try await publicDB.records(matching: query)
            return returnedUsers.count
        } catch let err {
            throw err
        }
    }
    
    func fetchUserRecord(with uid: String) async throws -> UserModel {
        let predicate = NSPredicate(format: "%K == %@", UserModelKeys.uid.rawValue, uid)
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        
        do {
            let (returnedResults, _) = try await publicDB.records(matching: query)
            let result = returnedResults[0].1
            switch result {
            case .success(let record):
                let user = self.unwrapUserRecord(from: record)
                if user == nil {
                    throw CKHelperError.castFailure
                }
                return user!
            case .failure(let err):
                throw err
            }
        } catch let err {
            throw err
        }
    }
    
    func fetchUserRecord(with recordID: CKRecord.ID) async throws -> UserModel {
        
        do {
            let record = try await fetchRecord(with: recordID)
            let user = self.unwrapUserRecord(from: record)
            if user == nil {
                throw CKHelperError.castFailure
            }
            return user!
        } catch let err {
            throw err
        }
        
    }
    
    func editUserRecord(with recordID: CKRecord.ID, edit username: String) async throws -> UserModel {
        do {
            // fetch record with id
            let record = try await fetchRecord(with: recordID)
            // change username in the record
            record[UserModelKeys.username.rawValue] = username as CKRecordValue
            // save changes
            let user = try await saveUserRecord(record: record)
            return user
        } catch let err {
            throw err
        }
    }
    
}
