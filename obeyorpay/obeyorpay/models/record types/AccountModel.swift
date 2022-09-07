//
//  AccountModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation

enum AccountModelKeys: String, CaseIterable {
    case uid = "uid"
    case personalTasks = "personalTasks"
    case jointTasks = "jointTasks"
    case sharedTasks = "sharedTasks"
    case payments = "payments"
    case entries = "entries"
    case evaluations = "evaluations"
    case jointInvitedTasks = "jointInvitedTasks"
    case sharedInvitedTasks = "sharedInvitedTasks"
}


class AccountModel: Identifiable, Equatable, Hashable {
    
    
    // conforms to Equatable
    static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
        return (lhs.uid == rhs.uid) && (lhs.personalTasks == rhs.personalTasks) && (lhs.jointTasks == rhs.jointTasks) && (lhs.sharedTasks == rhs.sharedTasks) && (lhs.payments == rhs.payments) && (lhs.entries == rhs.entries) && (lhs.entries == rhs.entries) && (lhs.evaluations == rhs.evaluations) && (lhs.jointInvitedTasks == rhs.jointInvitedTasks) && (lhs.sharedInvitedTasks == rhs.sharedInvitedTasks)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
        hasher.combine(personalTasks)
        hasher.combine(jointTasks)
        hasher.combine(sharedTasks)
        hasher.combine(payments)
        hasher.combine(entries)
        hasher.combine(evaluations)
        hasher.combine(jointInvitedTasks)
        hasher.combine(sharedInvitedTasks)
    }
    
    var uid: String
    var personalTasks: [TaskModel]
    var jointTasks: [TaskModel]
    var sharedTasks: [TaskModel]
    var payments: [PaymentModel]
    var entries: [EntryModel]
    var evaluations: [EvaluationModel]
    var jointInvitedTasks: [TaskModel]
    var sharedInvitedTasks: [TaskModel]
    
    init() {
        self.uid = ""
        self.personalTasks = []
        self.jointTasks = []
        self.sharedTasks = []
        self.payments = []
        self.entries = []
        self.evaluations = []
        self.jointInvitedTasks = []
        self.sharedInvitedTasks = []
    }
    
}
