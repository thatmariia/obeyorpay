//
//  EvaluationModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation

enum EvaluationModelKeys: String, CaseIterable {
    case periodStartDate = "periodStartDate"
    case periodEndDate = "periodEndDate"
    case jointUsers = "jointUsers"
    case payments = "payments"
    case task = "task"
    case count = "count"
    case target = "target"
    case totalCost = "totalCost"
    case build = "build"
}

class EvaluationModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: EvaluationModel, rhs: EvaluationModel) -> Bool {
        return (lhs.periodStartDate == rhs.periodStartDate) && (lhs.periodEndDate == rhs.periodEndDate) && (lhs.jointUsers == rhs.jointUsers) && (lhs.payments == rhs.payments) && (lhs.task == rhs.task) && (lhs.count == rhs.count) && (lhs.target == rhs.count) && (lhs.totalCost == rhs.totalCost) && (lhs.build = rhs.build)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(periodStartDate)
        hasher.combine(periodEndDate)
        hasher.combine(jointUsers)
        hasher.combine(payments)
        hasher.combine(task)
        hasher.combine(count)
        hasher.combine(target)
        hasher.combine(totalCost)
        hasher.combine(build)
    }
    
    var periodStartDate: Date
    var periodEndDate: Date
    var jointUsers: [UserModel]
    var payments: [PaymentModel]
    var task: TaskModel
    var count: Int
    var target: Int
    var totalCost: Double
    var build: Bool
    
    init() {
        self.periodStartDate = Date.now
        self.periodEndDate = Date.now
        self.jointUsers = []
        self.payments = []
        self.task = TaskModel()
        self.count = 0
        self.target = 0
        self.totalCost = 0
        self.build = true
    }
}
