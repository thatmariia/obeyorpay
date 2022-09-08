//
//  PaymentCKModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation

enum PaymentCKKeys: String, CaseIterable {
    case userRef = "user"
    case taskRef = "task"
    case timestamp = "timestamp"
    case evaluationRef = "evaluation"
    case amount = "amount"
}

class PaymentCKModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: PaymentCKModel, rhs: PaymentCKModel) -> Bool {
        return (lhs.userRef == rhs.userRef) && (lhs.taskRef == rhs.taskRef) && (lhs.timestamp == rhs.timestamp) && (lhs.evaluationRef == rhs.evaluationRef) && (lhs.amount == rhs.amount)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(userRef)
        hasher.combine(taskRef)
        hasher.combine(timestamp)
        hasher.combine(evaluationRef)
        hasher.combine(amount)
    }
    
    var recordName: String?
    var userRef: String
    var taskRef: String
    var timestamp: Date
    var evaluationRef: String
    var amount: Double
    
    init() {
        self.recordName = nil
        self.userRef = ""
        self.taskRef = ""
        self.timestamp = Date()
        self.evaluationRef = ""
        self.amount = 0
    }
    
    init(
        recordName: String,
        userRef: String,
        taskRef: String,
        timestamp: Date,
        evaluationRef: String,
        amount: Double
    ) {
        self.recordName = recordName
        self.userRef = userRef
        self.taskRef = taskRef
        self.timestamp = timestamp
        self.evaluationRef = evaluationRef
        self.amount = amount
    }
    
    func toStore() async -> PaymentStoreModel {
        do {
            let user = try await userDB.fetchUser(with: self.userRef)
            let task = try await taskDB.fetchTask(with: self.taskRef)
            let evaluation = try await evaluationDB.fetchEvaluation(with: self.evaluationRef)
            let payment = PaymentStoreModel(
                recordName: self.recordName ?? "",
                user: user,
                task: task,
                timestamp: self.timestamp,
                evaluation: evaluation,
                amount: self.amount
            )
            return payment
        } catch {
            return PaymentStoreModel()
        }
    }
}
