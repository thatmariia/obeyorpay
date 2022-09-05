//
//  TaskData.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation

enum TaskSpan: String {
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
    
    
    init() {
        self.title = ""
        self.creatorUser = UserModel()
        self.createdDate = Date.now
        self.jointUsers = []
        self.sharedUsers = []
        self.span = TaskSpan.day
        self.spanStartDate = Date.now
        self.lastPeriodStartDate = Date.now
        self.countCost = 0
        self.entries = []
        self.trackBeforeStart = false
        self.payments = []
        self.target = 0
        self.currentCount = 0
        self.evaluations = []
        self.color = 0
    }
}
