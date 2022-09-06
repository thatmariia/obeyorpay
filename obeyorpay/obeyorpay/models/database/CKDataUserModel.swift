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
    
    func fillUserRecord(into itemRecord: CKRecord, with user: UserModel) -> CKRecord {
        itemRecord[UserModelKeys.uid.rawValue]          = user.uid          as CKRecordValue
        itemRecord[UserModelKeys.username.rawValue]     = user.username     as CKRecordValue
        itemRecord[UserModelKeys.email.rawValue]        = user.email        as CKRecordValue
        itemRecord[UserModelKeys.firstName.rawValue]    = user.firstName    as CKRecordValue
        itemRecord[UserModelKeys.lastName.rawValue]     = user.lastName     as CKRecordValue
        return itemRecord
    }
    
    func extractUserRecord(from record: CKRecord) -> UserModel? {
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
    
    func saveUserRecord(record: CKRecord, completion: @escaping (Result<UserModel, Error>) -> ()) {
        
        saveRecord(record: record) { result in
            switch result {
            case .success(_):
                let extractedRecord = self.extractUserRecord(from: record)
                if extractedRecord == nil {
                    completion(.failure(CKHelperError.castFailure))
                    return
                }
                completion(.success(extractedRecord!))
                break
            case .failure(let err):
                completion(.failure(err))
                print(err.localizedDescription)
                break
            }
            
        }
    }
    
    // MARK: - database actions
    
    func addUserRecord(of user: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        
        // create record
        let itemRecord = fillUserRecord(
            into: CKRecord(recordType: userRecordType),
            with: user
        )
        
        // save record
        saveUserRecord(record: itemRecord) { result in
            switch result {
            case .success(let record):
                completion(.success(record))
                break
            case .failure(let err):
                completion(.failure(err))
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func fetchUserRecords(with username: String, completion: @escaping (Result<Int, Error>) -> ()) {
        let predicate = NSPredicate(format: "%K == %@", UserModelKeys.username.rawValue, username)
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [UserModelKeys.username.rawValue]
        operation.resultsLimit = 1000
        
        var nrReturnedUsers: Int = 0
        
        operation.recordMatchedBlock = { _, result in
            switch result {
            case .success(_):
                nrReturnedUsers += 1
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        operation.queryResultBlock = { result in
            switch result {
            case .success(_):
                completion(.success(nrReturnedUsers))
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        publicDB.add(operation)
        
    }
    
    func fetchUserRecord(with uid: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        let predicate = NSPredicate(format: "%K == %@", UserModelKeys.uid.rawValue, uid)
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = UserModelKeys.allCases.map { $0.rawValue }
        operation.resultsLimit = 1
        
        var returnedUser = UserModel()
        
        operation.recordMatchedBlock = { _, result in
            switch result {
            case .success(let record):
                let extractedRecord = self.extractUserRecord(from: record)
                if extractedRecord == nil {
                    completion(.failure(CKHelperError.castFailure))
                    return
                }
                returnedUser = extractedRecord!
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        
        operation.queryResultBlock = { result in
            switch result {
            case .success(_):
                if returnedUser.uid != "" {
                    completion(.success(returnedUser))
                } else {
                    completion(.failure(CKHelperError.cursorFailure))
                }
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        publicDB.add(operation)
    }
    
    func fetchUserRecord(with recordID: CKRecord.ID, completion: @escaping (Result<UserModel, Error>) -> ()) {
        
        // fetch record with id
        fetchRecord(with: recordID) { (result) in
            switch result {
            case .success(let record):
                
                let extractedRecord = self.extractUserRecord(from: record)
                if extractedRecord == nil {
                    completion(.failure(CKHelperError.castFailure))
                    return
                }
                completion(.success(extractedRecord!))
                
                
                break
            case .failure(let err):
                completion(.failure(err))
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func editUserRecord(with recordID: CKRecord.ID, edit username: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        
        // fetch record with id
        fetchRecord(with: recordID) { (result) in
            switch result {
            case .success(let record):
                // change username in the record
                record[UserModelKeys.username.rawValue] = username as CKRecordValue
                
                // save changes
                self.saveUserRecord(record: record) { result in
                    switch result {
                    case .success(let record):
                        completion(.success(record))
                        break
                    case .failure(let err):
                        completion(.failure(err))
                        print(err.localizedDescription)
                        break
                    }
                }
                break
            case .failure(let err):
                completion(.failure(err))
                print(err.localizedDescription)
                break
            }
        }
    }
    
}
