//
//  EntryModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation


enum EntryModelKeys: String, CaseIterable {
    case user = "user"
    case task = "task"
    case timestamp = "timestamp"
    case evaluation = "evaluation"
}

class EntryModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: EntryModel, rhs: EntryModel) -> Bool {
        return (lhs.user == rhs.user) && (lhs.task == rhs.task) && (lhs.timestamp == rhs.timestamp) && (lhs.evaluation == rhs.evaluation)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
        hasher.combine(task)
        hasher.combine(timestamp)
        hasher.combine(evaluation)
    }
    
    var user: UserModel
    var task: TaskModel
    var timestamp: Date
    var evaluation: EvaluationModel
    
    init() {
        self.user = UserModel()
        self.task = TaskModel()
        self.timestamp = Date.now
        self.evaluation = EvaluationModel()
    }
}