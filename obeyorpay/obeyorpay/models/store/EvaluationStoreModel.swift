//
//  EvaluationStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class EvaluationStoreModel {
    
    var recordName: String?
    var periodStartDate: Date
    var periodEndDate: Date
    var jointUsers: [UserStoreModel]
    var payments: [PaymentStoreModel]
    var task: TaskStoreModel
    var count: Int
    var target: Int
    var totalCost: Double
    var build: Bool
    
    init() {
        self.recordName = nil
        self.periodStartDate = Date()
        self.periodEndDate = Date()
        self.jointUsers = []
        self.payments = []
        self.task = TaskStoreModel()
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
        payments: [PaymentStoreModel],
        task: TaskStoreModel,
        count: Int,
        target: Int,
        totalCost: Double,
        build: Bool
    ) {
        self.recordName = recordName
        self.periodStartDate = periodStartDate
        self.periodEndDate = periodEndDate
        self.jointUsers = jointUsers
        self.payments = payments
        self.task = task
        self.count = count
        self.target = target
        self.totalCost = totalCost
        self.build = build
    }
}
