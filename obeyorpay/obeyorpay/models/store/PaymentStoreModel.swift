//
//  PaymentStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class PaymentStoreModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: PaymentStoreModel, rhs: PaymentStoreModel) -> Bool {
        return (lhs.recordName == rhs.recordName) &&
        (lhs.user == rhs.user) &&
        (lhs.task == rhs.task) &&
        (lhs.timestamp == rhs.timestamp) &&
        (lhs.evaluation == rhs.evaluation) &&
        (lhs.amount == rhs.amount)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(user)
        hasher.combine(task)
        hasher.combine(timestamp)
        hasher.combine(evaluation)
        hasher.combine(amount)
    }
    
    var recordName: String?
    var user: UserStoreModel
    var task: TaskStoreModel
    var timestamp: Date
    var evaluation: EvaluationStoreModel
    var amount: Double
    
    init() {
        self.recordName = nil
        self.user = UserStoreModel()
        self.task = TaskStoreModel()
        self.timestamp = Date()
        self.evaluation = EvaluationStoreModel()
        self.amount = 0
    }
    
    init(
        recordName: String,
        user: UserStoreModel,
        task: TaskStoreModel,
        timestamp: Date,
        evaluation: EvaluationStoreModel,
        amount: Double
    ) {
        self.recordName = recordName
        self.user = user
        self.task = task
        self.timestamp = timestamp
        self.evaluation = evaluation
        self.amount = amount
    }
}
