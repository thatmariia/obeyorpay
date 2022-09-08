//
//  TaskStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class TaskStoreModel {
    
    var recordName: String?
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
        self.recordName = nil
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
        self.trackBeforeStart = false
        self.payments = []
        self.target = 0
        self.currentCount = 0
        self.evaluations = []
        self.color = 0
        self.build = true
        self.jointInvitedUsers = []
        self.sharedInvitedUsers = []
    }
    
    init(
        recordName: String,
        title: String,
        creatorUser: UserStoreModel,
        createdDate: Date,
        jointUsers: [UserStoreModel],
        sharedUsers: [UserStoreModel],
        span: TaskSpan,
        spanStartDate: Date,
        lastPeriodStartDate: Date,
        countCost: Double,
        entries: [EntryStoreModel],
        trackBeforeStart: Bool,
        payments: [PaymentStoreModel],
        target: Int,
        currentCount: Int,
        evaluations: [EvaluationStoreModel],
        color: Int,
        build: Bool,
        jointInvitedUsers: [UserStoreModel],
        sharedInvitedUsers: [UserStoreModel]
    ) {
        self.recordName = recordName
        self.title = title
        self.creatorUser = creatorUser
        self.createdDate = createdDate
        self.jointUsers = jointUsers
        self.sharedUsers = sharedUsers
        self.span = span
        self.spanStartDate = spanStartDate
        self.lastPeriodStartDate = lastPeriodStartDate
        self.countCost = countCost
        self.entries = entries
        self.trackBeforeStart = trackBeforeStart
        self.payments = payments
        self.target = target
        self.currentCount = currentCount
        self.evaluations = evaluations
        self.color = color
        self.build = build
        self.jointInvitedUsers = jointInvitedUsers
        self.sharedInvitedUsers = sharedInvitedUsers
    }
}
