//
//  EvaluationCKModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation

enum EvaluationCKKeys: String, CaseIterable {
    case periodStartDate = "periodStartDate"
    case periodEndDate = "periodEndDate"
    case jointUsersRefs = "jointUsers"
    case paymentsRefs = "payments"
    case taskRef = "task"
    case count = "count"
    case target = "target"
    case totalCost = "totalCost"
    case build = "build"
}

class EvaluationCKModel {
    
    var recordName: String?
    var periodStartDate: Date
    var periodEndDate: Date
    var jointUsersRefs: [String]
    var paymentsRefs: [String]
    var taskRef: String
    var count: Int
    var target: Int
    var totalCost: Double
    var build: Bool
    
    init() {
        self.recordName = nil
        self.periodStartDate = Date()
        self.periodEndDate = Date()
        self.jointUsersRefs = []
        self.paymentsRefs = []
        self.taskRef = ""
        self.count = 0
        self.target = 0
        self.totalCost = 0
        self.build = true
    }
    
    init(
        recordName: String,
        periodStartDate: Date,
        periodEndDate: Date,
        jointUsersRefs: [String],
        paymentsRefs: [String],
        taskRef: String,
        count: Int,
        target: Int,
        totalCost: Double,
        build: Bool
    ) {
        self.recordName = nil
        self.periodStartDate = Date()
        self.periodEndDate = Date()
        self.jointUsersRefs = []
        self.paymentsRefs = []
        self.taskRef = ""
        self.count = 0
        self.target = 0
        self.totalCost = 0
        self.build = true
    }
    
    func toStore() async -> EvaluationStoreModel {
        do {
            let jointUsers = try await userDB.fetchUsers(with: self.jointUsersRefs)
            let payments = try await paymentDB.fetchPayments(with: self.paymentsRefs)
            let task = try await taskDB.fetchTask(with: self.taskRef)
            let evaluation = EvaluationStoreModel(
                recordName: self.recordName ?? "",
                periodStartDate: self.periodStartDate,
                periodEndDate: self.periodEndDate,
                jointUsers: jointUsers,
                payments: payments,
                task: task,
                count: self.count,
                target: self.target,
                totalCost: self.totalCost,
                build: self.build
            )
            return evaluation
        } catch {
            return EvaluationStoreModel()
        }
    }
}
