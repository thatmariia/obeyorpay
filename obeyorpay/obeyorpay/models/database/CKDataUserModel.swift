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
    
    func fillRecord(into itemRecord: CKRecord, with user: UserModel) -> CKRecord {
        itemRecord[UserModelKeys.uid.rawValue]          = user.uid          as CKRecordValue
        itemRecord[UserModelKeys.username.rawValue]     = user.username     as CKRecordValue
        itemRecord[UserModelKeys.email.rawValue]        = user.email        as CKRecordValue
        itemRecord[UserModelKeys.firstName.rawValue]    = user.firstName    as CKRecordValue
        itemRecord[UserModelKeys.lastName.rawValue]     = user.lastName     as CKRecordValue
        return itemRecord
    }
    
    func extractRecord(from record: CKRecord) -> UserModel? {
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
    
    // MARK: - database actions
    
    func addRecord(of user: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        
        let itemRecord = fillRecord(
            into: CKRecord(recordType: userRecordType),
            with: user
        )
        
        publicDB.save(itemRecord) { record, err in
            DispatchQueue.main.async {
                
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let record = record else {
                    completion(.failure(CKHelperError.recordFailure))
                    return
                }
                
                let extractedRecord = self.extractRecord(from: record)
                if extractedRecord == nil {
                    completion(.failure(CKHelperError.castFailure))
                    return
                }
                completion(.success(extractedRecord!))
            }
        }
        
    }
    
    func fetchRecord(with uid: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        let predicate = NSPredicate(format: "%K == %@", UserModelKeys.uid.rawValue, uid)
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = UserModelKeys.allCases.map { $0.rawValue }
        operation.resultsLimit = 1
        
        var returnedUser = UserModel()
        
        operation.recordMatchedBlock = { recordID, result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    let extractedRecord = self.extractRecord(from: record)
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
        }
        
        operation.queryResultBlock = { result in
            DispatchQueue.main.async {
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
        }
        publicDB.add(operation)
    }
    
    func fetchRecord(with recordID: CKRecord.ID, completion: @escaping (Result<UserModel, Error>) -> ()) {
        publicDB.fetch(withRecordID: recordID) { record, err in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let record = record else {
                    completion(.failure(CKHelperError.recordFailure))
                    return
                }
                let extractedRecord = self.extractRecord(from: record)
                if extractedRecord == nil {
                    completion(.failure(CKHelperError.castFailure))
                    return
                }
                completion(.success(extractedRecord!))
            }
        }
    }
    
}
