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
        (lhs.taskRef == rhs.taskRef) &&
        (lhs.timestamp == rhs.timestamp) &&
        (lhs.evaluationRef == rhs.evaluationRef) &&
        (lhs.amount == rhs.amount)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(user)
        hasher.combine(taskRef)
        hasher.combine(timestamp)
        hasher.combine(evaluationRef)
        hasher.combine(amount)
    }
    
    var recordName: String?
    var user: UserStoreModel
    var taskRef: String
    var timestamp: Date
    var evaluationRef: String
    var amount: Double
    
    init() {
        self.recordName = nil
        self.user = UserStoreModel()
        self.taskRef = ""
        self.timestamp = Date()
        self.evaluationRef = ""
        self.amount = 0
    }
    
    init(
        user: UserStoreModel,
        taskRef: String,
        evaluationRef: String,
        amount: Double
    ) {
        self.recordName = nil
        self.user = user
        self.taskRef = taskRef
        self.timestamp = Date()
        self.evaluationRef = evaluationRef
        self.amount = amount
    }
    
    init(
        recordName: String,
        user: UserStoreModel,
        taskRef: String,
        timestamp: Date,
        evaluationRef: String,
        amount: Double
    ) {
        self.recordName = recordName
        self.user = user
        self.taskRef = taskRef
        self.timestamp = timestamp
        self.evaluationRef = evaluationRef
        self.amount = amount
    }
    
    func toCK() -> PaymentCKModel {
        return PaymentCKModel(
            recordName: self.recordName ?? "",
            userRef: self.user.recordName ?? "",
            taskRef: self.taskRef,
            timestamp: self.timestamp,
            evaluationRef: self.evaluationRef,
            amount: self.amount
        )
    }
}
