//
//  EntryStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class EntryStoreModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: EntryStoreModel, rhs: EntryStoreModel) -> Bool {
        return (lhs.recordName == rhs.recordName) &&
        (lhs.user == rhs.user) &&
        (lhs.taskRef == rhs.taskRef) &&
        (lhs.timestamp == rhs.timestamp) &&
        (lhs.evaluationRef == rhs.evaluationRef)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(user)
        hasher.combine(taskRef)
        hasher.combine(timestamp)
        hasher.combine(evaluationRef)
    }
    
    var recordName: String?
    var user: UserStoreModel
    var taskRef: String
    var timestamp: Date
    var evaluationRef: String
    
    init() {
        self.recordName = nil
        self.user = UserStoreModel()
        self.taskRef = ""
        self.timestamp = Date()
        self.evaluationRef = ""
    }
    
    init(
        recordName: String,
        user: UserStoreModel,
        taskRef: String,
        timestamp: Date,
        evaluationRef: String
    ) {
        self.recordName =  recordName
        self.user = user
        self.taskRef = taskRef
        self.timestamp = timestamp
        self.evaluationRef = evaluationRef
    }
}
