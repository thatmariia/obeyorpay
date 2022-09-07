//
//  TaskData.swift
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

enum TaskModelKeys: String, CaseIterable {
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

struct TaskModel: Identifiable, Equatable, Hashable {
    
    // conforms to Identifiable
    var id = UUID().uuidString
    
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
    
    init(user: UserModel, title: String, span: TaskSpan, spanStartDate: Date, trackBeforeStart: Bool, target: Int, build: Bool, countCost: Double, color: Int) {
        self.recordName = nil
        self.title = title
        self.span = span
        self.spanStartDate = spanStartDate
        self.trackBeforeStart = trackBeforeStart
        self.target = target
        self.build = build
        self.countCost = countCost
        self.color = color
        
        self.creatorUserRef = user.recordName!
        self.createdDate = Date()
        self.jointUsersRefs = [user.recordName!]
        self.sharedUsersRefs = []
        self.jointInvitedUsersRefs = []
        self.sharedInvitedUsersRefs = []
        self.lastPeriodStartDate = Date.distantPast // TODO:: if trackBeforeStart, pick span before startDate, otherwise just startDate
        self.entriesRefs = []
        self.paymentsRefs = []
        self.currentCount = 0
        self.evaluationsRefs = []
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
}
