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
        (lhs.entriesRefs == rhs.entriesRefs) &&
        (lhs.trackBeforeStart == rhs.trackBeforeStart) &&
        (lhs.paymentsRefs == rhs.paymentsRefs) &&
        (lhs.target == rhs.target) &&
        (lhs.currentCount == rhs.currentCount) &&
        (lhs.evaluationsRefs == rhs.evaluationsRefs) &&
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
        hasher.combine(entriesRefs)
        hasher.combine(trackBeforeStart)
        hasher.combine(paymentsRefs)
        hasher.combine(target)
        hasher.combine(currentCount)
        hasher.combine(evaluationsRefs)
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
    var entriesRefs: [String]
    var trackBeforeStart: Bool
    var paymentsRefs: [String]
    var target: Int
    var currentCount: Int
    var evaluationsRefs: [String]
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
        self.entriesRefs = []
        self.trackBeforeStart = false
        self.paymentsRefs = []
        self.target = 0
        self.currentCount = 0
        self.evaluationsRefs = []
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
        entriesRefs: [String],
        trackBeforeStart: Bool,
        paymentsRefs: [String],
        target: Int,
        currentCount: Int,
        evaluationsRefs: [String],
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
        self.entriesRefs = entriesRefs
        self.trackBeforeStart = trackBeforeStart
        self.paymentsRefs = paymentsRefs
        self.target = target
        self.currentCount = currentCount
        self.evaluationsRefs = evaluationsRefs
        self.color = color
        self.build = build
        self.jointInvitedUsers = jointInvitedUsers
        self.sharedInvitedUsers = sharedInvitedUsers
    }
    
    init(
        user: MainUserStoreModel,
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

        self.creatorUser = user.toUser()
        self.createdDate = Date()
        self.jointUsers = [user.toUser()]
        self.sharedUsers = []
        self.jointInvitedUsers = []
        self.sharedInvitedUsers = []
        self.lastPeriodStartDate = Date.distantPast // TODO:: if trackBeforeStart, pick span before startDate, otherwise just startDate
        self.entriesRefs = []
        self.paymentsRefs = []
        self.currentCount = 0
        self.evaluationsRefs = []
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
            entriesRefs: self.entriesRefs,
            trackBeforeStart: self.trackBeforeStart,
            paymentsRefs: self.paymentsRefs,
            target: self.target,
            currentCount: self.currentCount,
            evaluationsRefs: self.evaluationsRefs,
            color: self.color,
            build: self.build,
            jointInvitedUsersRefs: self.jointInvitedUsers.map { $0.recordName ?? "" },
            sharedInvitedUsersRefs: self.sharedInvitedUsers.map { $0.recordName ?? "" })
    }
}
