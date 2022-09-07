//
//  PaymentCKModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation

enum PaymentCKKeys: String, CaseIterable {
    case user = "user"
    case task = "task"
    case timestamp = "timestamp"
    case evaluation = "evaluation"
}

class PaymentCKModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: PaymentModel, rhs: PaymentModel) -> Bool {
        return (lhs.user == rhs.user) && (lhs.task == rhs.task) && (lhs.timestamp == rhs.timestamp) && (lhs.evaluation == rhs.evaluation)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
        hasher.combine(task)
        hasher.combine(timestamp)
        hasher.combine(evaluation)
    }
    
    var user: UserCKModel
    var task: TaskCKModel
    var timestamp: Date
    var evaluation: EvaluationCKModel
    
    init() {
        self.user = UserCKModel()
        self.task = TaskCKModel()
        self.timestamp = Date.now // TODO
        self.evaluation = EvaluationCKModel()
    }
}
