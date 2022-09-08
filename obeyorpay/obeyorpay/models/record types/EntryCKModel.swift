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
    case evaluationRef = "evaluation"
}

class EntryCKModel {
    
    var recordName: String?
    var userRef: String
    var taskRef: String
    var timestamp: Date
    var evaluationRef: String
    
    init() {
        self.recordName = nil
        self.userRef = ""
        self.taskRef = ""
        self.timestamp = Date()
        self.evaluationRef = ""
    }
    
    init(
        recordName: String,
        userRef: String,
        taskRef: String,
        timestamp: Date,
        evaluationRef: String
    ) {
        self.recordName = recordName
        self.userRef = userRef
        self.taskRef = taskRef
        self.timestamp = timestamp
        self.evaluationRef = evaluationRef
    }
    
    func toStore() async -> EntryStoreModel {
        do {
            let user = try await userDB.fetchUser(with: self.userRef)
            let task = try await taskDB.fetchTask(with: self.taskRef)
            let evaluation = try await evaluationDB.fetchEvaluation(with: self.evaluationRef)
            let entry = EntryStoreModel(
                recordName: self.recordName ?? "",
                user: user,
                task: task,
                timestamp: timestamp,
                evaluation: evaluation
            )
            return entry
        } catch {
            return EntryStoreModel()
        }
    }
}
