//
//  TaskStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class TaskStoreModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: TaskStoreModel, rhs: TaskStoreModel) -> Bool {
        return (lhs.recordName == rhs.recordName) &&
        (lhs.title == rhs.title) &&
        (lhs.creatorUser == rhs.creatorUser) &&
        (lhs.createdDate == rhs.createdDate) &&
        (lhs.jointUsers == rhs.jointUsers) &&
        (lhs.sharedUsers == rhs.sharedUsers) &&
        (lhs.span == rhs.span) &&
        (lhs.spanStartDate == rhs.spanStartDate) &&
        (lhs.lastPeriodStartDate == rhs.lastPeriodStartDate) &&
        (lhs.countCost == rhs.countCost) &&
        (lhs.entries == rhs.entries) &&
        (lhs.trackBeforeStart == rhs.trackBeforeStart) &&
        (lhs.payments == rhs.payments) &&
        (lhs.target == rhs.target) &&
        (lhs.currentCount == rhs.currentCount) &&
        (lhs.evaluations == rhs.evaluations) &&
        (lhs.color == rhs.color) &&
        (lhs.build == rhs.build) &&
        (lhs.jointInvitedUsers == rhs.jointInvitedUsers) &&
        (lhs.sharedInvitedUsers == rhs.sharedInvitedUsers)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(title)
        hasher.combine(creatorUser)
        hasher.combine(createdDate)
        hasher.combine(jointUsers)
        hasher.combine(sharedUsers)
        hasher.combine(span)
        hasher.combine(spanStartDate)
        hasher.combine(lastPeriodStartDate)
        hasher.combine(countCost)
        hasher.combine(entries)
        hasher.combine(trackBeforeStart)
        hasher.combine(payments)
        hasher.combine(target)
        hasher.combine(currentCount)
        hasher.combine(evaluations)
        hasher.combine(color)
        hasher.combine(build)
        hasher.combine(jointInvitedUsers)
        hasher.combine(sharedInvitedUsers)
    }
    
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
    
    init(
        user: UserStoreModel,
        title: String,
        span: TaskSpan,
        spanStartDate: Date,
        trackBeforeStart: Bool,
        target: Int,
        build: Bool,
        countCost: Double,
        color: Int
    ) {
        self.recordName = nil
        self.title = title
        self.span = span
        self.spanStartDate = spanStartDate
        self.trackBeforeStart = trackBeforeStart
        self.target = target
        self.build = build
        self.countCost = countCost
        self.color = color

        self.creatorUser = user
        self.createdDate = Date()
        self.jointUsers = [user]
        self.sharedUsers = []
        self.jointInvitedUsers = []
        self.sharedInvitedUsers = []
        self.lastPeriodStartDate = Date.distantPast // TODO:: if trackBeforeStart, pick span before startDate, otherwise just startDate
        self.entries = []
        self.payments = []
        self.currentCount = 0
        self.evaluations = []
    }
    
    func toCK() -> TaskCKModel {
        return TaskCKModel(
            recordName: self.recordName ?? "",
            title: self.title,
            creatorUserRef: self.creatorUser.recordName ?? "",
            createdDate: self.createdDate,
            jointUsersRefs: self.jointUsers.map { $0.recordName ?? "" },
            sharedUsersRefs: self.sharedUsers.map { $0.recordName ?? "" },
            span: self.span,
            spanStartDate: self.spanStartDate,
            lastPeriodStartDate: self.lastPeriodStartDate,
            countCost: self.countCost,
            entriesRefs: self.entries.map { $0.recordName ?? "" },
            trackBeforeStart: self.trackBeforeStart,
            paymentsRefs: self.payments.map { $0.recordName ?? "" },
            target: self.target,
            currentCount: self.currentCount,
            evaluationsRefs: self.evaluations.map { $0.recordName ?? "" },
            color: self.color,
            build: self.build,
            jointInvitedUsersRefs: self.jointInvitedUsers.map { $0.recordName ?? "" },
            sharedInvitedUsersRefs: self.sharedInvitedUsers.map { $0.recordName ?? "" })
    }
}
