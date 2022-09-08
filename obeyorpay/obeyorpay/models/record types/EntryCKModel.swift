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

class EntryCKModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: EntryCKModel, rhs: EntryCKModel) -> Bool {
        return (lhs.recordName == rhs.recordName) && (lhs.userRef == rhs.userRef) && (lhs.taskRef == rhs.taskRef) && (lhs.timestamp == rhs.timestamp) && (lhs.evaluationRef == rhs.evaluationRef)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(userRef)
        hasher.combine(taskRef)
        hasher.combine(timestamp)
        hasher.combine(evaluationRef)
    }
    
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
    
    func toStore() -> EntryStoreModel {
        // TODO:: implement
        return EntryStoreModel()
    }
}
