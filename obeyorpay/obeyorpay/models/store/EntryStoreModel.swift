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
        (lhs.task == rhs.task) &&
        (lhs.timestamp == rhs.timestamp) &&
        (lhs.evaluation == rhs.evaluation)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(user)
        hasher.combine(task)
        hasher.combine(timestamp)
        hasher.combine(evaluation)
    }
    
    var recordName: String?
    var user: UserStoreModel
    var task: TaskStoreModel
    var timestamp: Date
    var evaluation: EvaluationStoreModel
    
    init() {
        self.recordName = nil
        self.user = UserStoreModel()
        self.task = TaskStoreModel()
        self.timestamp = Date()
        self.evaluation = EvaluationStoreModel()
    }
    
    init(
        recordName: String,
        user: UserStoreModel,
        task: TaskStoreModel,
        timestamp: Date,
        evaluation: EvaluationStoreModel
    ) {
        self.recordName =  recordName
        self.user = user
        self.task = task
        self.timestamp = timestamp
        self.evaluation = evaluation
    }
}
