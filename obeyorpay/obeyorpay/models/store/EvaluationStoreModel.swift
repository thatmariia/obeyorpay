//
//  EvaluationStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class EvaluationStoreModel {
    var periodStartDate: Date
    var periodEndDate: Date
    var jointUsers: [UserStoreModel]
    var payments: [PaymentStoreModel]
    var task: TaskStoreModel
    var count: Int
    var target: Int
    var totalCost: Double
    
    init() {
        self.periodStartDate = Date()
        self.periodEndDate = Date()
        self.jointUsers = []
        self.payments = []
        self.task = TaskStoreModel()
        self.count = 0
        self.target = 0
        self.totalCost = 0
    }
}
