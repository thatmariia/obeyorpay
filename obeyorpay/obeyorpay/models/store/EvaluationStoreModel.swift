//
//  EvaluationStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class EvaluationStoreModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: EvaluationStoreModel, rhs: EvaluationStoreModel) -> Bool {
        return (lhs.recordName == rhs.recordName) &&
        (lhs.periodStartDate == rhs.periodStartDate) &&
        (lhs.periodEndDate == rhs.periodEndDate) &&
        (lhs.jointUsers == rhs.jointUsers) &&
        (lhs.paymentsRefs == rhs.paymentsRefs) &&
        (lhs.taskRef == rhs.taskRef) &&
        (lhs.count == rhs.count) &&
        (lhs.target == rhs.target) &&
        (lhs.totalCost == rhs.totalCost) &&
        (lhs.build == rhs.build)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(periodStartDate)
        hasher.combine(periodEndDate)
        hasher.combine(jointUsers)
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
    var jointUsers: [UserStoreModel]
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
        self.jointUsers = []
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
        jointUsers: [UserStoreModel],
        paymentsRefs: [String],
        taskRef: String,
        count: Int,
        target: Int,
        totalCost: Double,
        build: Bool
    ) {
        self.recordName = recordName
        self.periodStartDate = periodStartDate
        self.periodEndDate = periodEndDate
        self.jointUsers = jointUsers
        self.paymentsRefs = paymentsRefs
        self.taskRef = taskRef
        self.count = count
        self.target = target
        self.totalCost = totalCost
        self.build = build
    }
}
