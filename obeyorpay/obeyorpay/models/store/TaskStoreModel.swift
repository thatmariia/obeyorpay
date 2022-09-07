//
//  TaskStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class TaskStoreModel {
    var title: String
    var creatorUser: UserStoreModel
    var createdDate: Date
    var jointUsers: [UserStoreModel]
    var sharedUsers: [UserStoreModel]
    var span: TaskSpan
    var spanStartDate: Date
    var lastPeriodStartDate: Date
    var countCost: Double
    var entries: [EntryStoreModel]
    var trackBeforeStart: Bool
    var payments: [PaymentStoreModel]
    var target: Int
    var currentCount: Int
    var evaluations: [EvaluationStoreModel]
    var color: Int
    var build: Bool
    var jointInvitedUsers: [UserStoreModel]
    var sharedInvitedUsers: [UserStoreModel]
    
    init() {
            self.title = ""
            self.creatorUser = UserStoreModel()
            self.createdDate = Date()
            self.jointUsers = []
            self.sharedUsers = []
            self.span = TaskSpan.day
            self.spanStartDate = Date()
            self.lastPeriodStartDate = Date.distantPast
            self.countCost = 0
            self.entries = []
            self.trackBeforeStart = true
            self.payments = []
            self.target = 0
            self.currentCount = 0
            self.evaluations = []
            self.color = 0
            self.build = false
            self.jointInvitedUsers = []
            self.sharedInvitedUsers = []
        }
}
