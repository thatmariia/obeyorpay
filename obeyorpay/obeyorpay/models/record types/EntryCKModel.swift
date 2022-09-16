//
//  EntryCKModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


enum EntryCKKeys: String, CaseIterable {
    case userRef = "user"
    case taskRef = "task"
    case timestamp = "timestamp"
}

class EntryCKModel {
    
    var recordName: String?
    var userRef: String
    var taskRef: String
    var timestamp: Date
    
    init() {
        self.recordName = nil
        self.userRef = ""
        self.taskRef = ""
        self.timestamp = Date()
    }
    
    init(
        recordName: String,
        userRef: String,
        taskRef: String,
        timestamp: Date
    ) {
        self.recordName = recordName
        self.userRef = userRef
        self.taskRef = taskRef
        self.timestamp = timestamp
    }
    
    func toStore() async -> EntryStoreModel {
        do {
            let user = try await userDB.fetchUser(with: self.userRef)
            //let task = try await taskDB.fetchTask(with: self.taskRef)
            //let evaluation = try await evaluationDB.fetchEvaluation(with: self.evaluationRef)
            let entry = EntryStoreModel(
                recordName: self.recordName ?? "",
                user: user,
                taskRef: self.taskRef,
                timestamp: timestamp
            )
            return entry
        } catch {
            return EntryStoreModel()
        }
    }
}
