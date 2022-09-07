//
//  TaskData.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation

enum TaskSpan: String, CaseIterable {
    case day = "daily"
    case week = "weekly"
    case month = "monthly"
    case year = "yearly"
}

enum TaskDataModelKeys: String, CaseIterable {
    case title = "title"
    case creatorUser = "creatorUser"
    case createdDate = "createdDate"
    case jointUsers = "jointUsers"
    case sharedUsers = "sharedUsers"
    case span = "span"
    case spanStartDate = "spanStartDate"
    case lastPeriodStartDate = "lastPeriodStartDate"
    case countCost = "countCost"
    case entries = "entries"
    case trackBeforeStart = "trackBeforeStart"
    case payments = "payments"
    case target = "target"
    case currentCount = "currentCount"
    case evaluations = "evaluations"
    case color = "color"
    case build = "build"
    case jointInvitedUsers = "jointInvitedUsers"
    case sharedInvitedUsers = "sharedInvitedUsers"
}

struct TaskModel: Identifiable, Equatable, Hashable {
    
    // conforms to Identifiable
    var id = UUID().uuidString
    
    var title: String
    var creatorUser: UserModel
    var createdDate: Date
    var jointUsers: [UserModel]
    var sharedUsers: [UserModel]
    var span: TaskSpan
    var spanStartDate: Date
    var lastPeriodStartDate: Date
    var countCost: Double
    var entries: [EntryModel]
    var trackBeforeStart: Bool
    var payments: [PaymentModel]
    var target: Int
    var currentCount: Int
    var evaluations: [EvaluationModel]
    var color: Int
    var build: Bool
    var jointInvitedUsers: [UserModel]
    var sharedInvitedUsers: [UserModel]
    
    
    init() {
        self.title = ""
        self.creatorUser = UserModel()
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
    
    init(user: UserModel, title: String, span: TaskSpan, spanStartDate: Date, trackBeforeStart: Bool, target: Int, build: Bool, countCost: Double, color: Int) {
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
        self.jointUsers = []
        self.sharedUsers = []
        self.jointInvitedUsers = []
        self.sharedInvitedUsers = []
        self.lastPeriodStartDate = Date.distantPast
        self.entries = []
        self.payments = []
        self.currentCount = 0
        self.evaluations = []
    }
}
