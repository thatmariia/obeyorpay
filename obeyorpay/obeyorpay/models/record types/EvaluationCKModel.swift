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

class EvaluationCKModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: EvaluationCKModel, rhs: EvaluationCKModel) -> Bool {
        return (lhs.recordName == rhs.recordName) && (lhs.periodStartDate == rhs.periodStartDate) && (lhs.periodEndDate == rhs.periodEndDate) && (lhs.jointUsersRefs == rhs.jointUsersRefs) && (lhs.paymentsRefs == rhs.paymentsRefs) && (lhs.taskRef == rhs.taskRef) && (lhs.count == rhs.count) && (lhs.target == rhs.count) && (lhs.totalCost == rhs.totalCost) && (lhs.build == rhs.build)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(periodStartDate)
        hasher.combine(periodEndDate)
        hasher.combine(jointUsersRefs)
        hasher.combine(paymentsRefs)
        hasher.combine(taskRef)
        hasher.combine(count)
        hasher.combine(target)
        hasher.combine(totalCost)
        hasher.combine(build)
    }
    
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
