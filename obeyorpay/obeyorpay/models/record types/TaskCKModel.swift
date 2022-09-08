//
//  TaskCKModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation
import CloudKit

enum TaskSpan: String, CaseIterable {
    case day = "daily"
    case week = "weekly"
    case month = "monthly"
    case year = "yearly"
    
    func toInt() -> Int {
        switch self {
        case .day:
            return 1
        case .week:
            return 2
        case .month:
            return 3
        case .year:
            return 4
        }
    }
}

enum TaskCKKeys: String, CaseIterable {
    case title = "title"
    case creatorUserRef = "creatorUser"
    case createdDate = "createdDate"
    case jointUsersRefs = "jointUsers"
    case sharedUsersRefs = "sharedUsers"
    case span = "span"
    case spanStartDate = "spanStartDate"
    case lastPeriodStartDate = "lastPeriodStartDate"
    case countCost = "countCost"
    case entriesRefs = "entries"
    case trackBeforeStart = "trackBeforeStart"
    case paymentsRefs = "payments"
    case target = "target"
    case currentCount = "currentCount"
    case evaluationsRefs = "evaluations"
    case color = "color"
    case build = "build"
    case jointInvitedUsersRefs = "jointInvitedUsers"
    case sharedInvitedUsersRefs = "sharedInvitedUsers"
}

class TaskCKModel {
    
    var recordName: String?
    var title: String
    var creatorUserRef: String
    var createdDate: Date
    var jointUsersRefs: [String]
    var sharedUsersRefs: [String]
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
    var jointInvitedUsersRefs: [String]
    var sharedInvitedUsersRefs: [String]
    
    
    init() {
        self.recordName = nil
        self.title = ""
        self.creatorUserRef = ""
        self.createdDate = Date()
        self.jointUsersRefs = []
        self.sharedUsersRefs = []
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
        self.jointInvitedUsersRefs = []
        self.sharedInvitedUsersRefs = []
    }
    
    init(
        recordName: String,
        title: String,
        creatorUserRef: String,
        createdDate: Date,
        jointUsersRefs: [String],
        sharedUsersRefs: [String],
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
        jointInvitedUsersRefs: [String],
        sharedInvitedUsersRefs: [String]
    ) {
        self.recordName = recordName
        self.title = title
        self.creatorUserRef = creatorUserRef
        self.createdDate = createdDate
        self.jointUsersRefs = jointUsersRefs
        self.sharedUsersRefs = sharedUsersRefs
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
        self.jointInvitedUsersRefs = jointInvitedUsersRefs
        self.sharedInvitedUsersRefs = sharedInvitedUsersRefs
    }
    
    func toStore() async -> TaskStoreModel {
        do {
            let creatorUser = try await userDB.fetchUser(with: self.creatorUserRef)
            let jointUsers = try await userDB.fetchUsers(with: self.jointUsersRefs)
            let sharedUsers = try await userDB.fetchUsers(with: self.sharedUsersRefs)
            let entries = try await entryDB.fetchEntries(with: self.entriesRefs)
            let payments = try await paymentDB.fetchPayments(with: self.paymentsRefs)
            let evaluations = try await evaluationDB.fetchEvaluations(with: self.evaluationsRefs)
            let jointInvitedUsers = try await userDB.fetchUsers(with: self.jointInvitedUsersRefs)
            let sharedInvitedUsers = try await userDB.fetchUsers(with: self.sharedInvitedUsersRefs)
            let task = TaskStoreModel(
                recordName: self.recordName ?? "",
                title: self.title,
                creatorUser: creatorUser,
                createdDate: self.createdDate,
                jointUsers: jointUsers,
                sharedUsers: sharedUsers,
                span: self.span,
                spanStartDate: self.spanStartDate,
                lastPeriodStartDate: self.lastPeriodStartDate,
                countCost: self.countCost,
                entries: entries,
                trackBeforeStart: self.trackBeforeStart,
                payments: payments,
                target: self.target,
                currentCount: self.currentCount,
                evaluations: evaluations,
                color: self.color,
                build: self.build,
                jointInvitedUsers: jointInvitedUsers,
                sharedInvitedUsers: sharedInvitedUsers
            )
            return task
        } catch {
            return TaskStoreModel()
        }
    }
}
