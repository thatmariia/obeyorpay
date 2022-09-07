//
//  AccountCKModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation

enum AccountCKKeys: String, CaseIterable {
    case personalTasksRefs = "personalTasks"
    case jointTasksRefs = "jointTasks"
    case sharedTasksRefs = "sharedTasks"
    case paymentsRefs = "payments"
    case entriesRefs = "entries"
    case evaluationsRefs = "evaluations"
    case jointInvitedTasksRefs = "jointInvitedTasks"
    case sharedInvitedTasksRefs = "sharedInvitedTasks"
}


class AccountCKModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: AccountCKModel, rhs: AccountCKModel) -> Bool {
        return (lhs.personalTasksRefs == rhs.personalTasksRefs) &&
        (lhs.jointTasksRefs == rhs.jointTasksRefs) &&
        (lhs.sharedTasksRefs == rhs.sharedTasksRefs) &&
        (lhs.paymentsRefs == rhs.paymentsRefs) &&
        (lhs.entriesRefs == rhs.entriesRefs) &&
        (lhs.entriesRefs == rhs.entriesRefs) &&
        (lhs.evaluationsRefs == rhs.evaluationsRefs) &&
        (lhs.jointInvitedTasksRefs == rhs.jointInvitedTasksRefs) &&
        (lhs.sharedInvitedTasksRefs == rhs.sharedInvitedTasksRefs)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(personalTasksRefs)
        hasher.combine(jointTasksRefs)
        hasher.combine(sharedTasksRefs)
        hasher.combine(paymentsRefs)
        hasher.combine(entriesRefs)
        hasher.combine(evaluationsRefs)
        hasher.combine(jointInvitedTasksRefs)
        hasher.combine(sharedInvitedTasksRefs)
    }
    
    var personalTasksRefs: [String]
    var jointTasksRefs: [String]
    var sharedTasksRefs: [String]
    var paymentsRefs: [String]
    var entriesRefs: [String]
    var evaluationsRefs: [String]
    var jointInvitedTasksRefs: [String]
    var sharedInvitedTasksRefs: [String]
    
    init() {
        self.personalTasksRefs = []
        self.jointTasksRefs = []
        self.sharedTasksRefs = []
        self.paymentsRefs = []
        self.entriesRefs = []
        self.evaluationsRefs = []
        self.jointInvitedTasksRefs = []
        self.sharedInvitedTasksRefs = []
    }
    
}
