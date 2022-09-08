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
        return (lhs.recordName == rhs.recordName) &&
        (lhs.personalTasksRefs == rhs.personalTasksRefs) &&
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
        hasher.combine(recordName)
        hasher.combine(personalTasksRefs)
        hasher.combine(jointTasksRefs)
        hasher.combine(sharedTasksRefs)
        hasher.combine(paymentsRefs)
        hasher.combine(entriesRefs)
        hasher.combine(evaluationsRefs)
        hasher.combine(jointInvitedTasksRefs)
        hasher.combine(sharedInvitedTasksRefs)
    }
    
    var recordName: String?
    var personalTasksRefs: [String]
    var jointTasksRefs: [String]
    var sharedTasksRefs: [String]
    var paymentsRefs: [String]
    var entriesRefs: [String]
    var evaluationsRefs: [String]
    var jointInvitedTasksRefs: [String]
    var sharedInvitedTasksRefs: [String]
    
    init() {
        self.recordName = nil
        self.personalTasksRefs = []
        self.jointTasksRefs = []
        self.sharedTasksRefs = []
        self.paymentsRefs = []
        self.entriesRefs = []
        self.evaluationsRefs = []
        self.jointInvitedTasksRefs = []
        self.sharedInvitedTasksRefs = []
    }
    
    init(
        recordName: String,
        personalTasksRefs: [String],
        jointTasksRefs: [String],
        sharedTasksRefs: [String],
        paymentsRefs: [String],
        entriesRefs: [String],
        evaluationsRefs: [String],
        jointInvitedTasksRefs: [String],
        sharedInvitedTasksRefs: [String]
    ) {
        self.recordName = recordName
        self.personalTasksRefs = personalTasksRefs
        self.jointTasksRefs = jointTasksRefs
        self.sharedTasksRefs = sharedTasksRefs
        self.paymentsRefs = paymentsRefs
        self.entriesRefs = entriesRefs
        self.evaluationsRefs = evaluationsRefs
        self.jointInvitedTasksRefs = jointInvitedTasksRefs
        self.sharedInvitedTasksRefs = sharedInvitedTasksRefs
    }
    
    func toStore() async -> AccountStoreModel {
        do {
            let personalTasks = try await taskDB.fetchTasks(with: self.personalTasksRefs)
            let jointTasks = try await taskDB.fetchTasks(with: self.jointTasksRefs)
            let sharedTasks = try await taskDB.fetchTasks(with: self.sharedTasksRefs)
            let payments = try await paymentDB.fetchPayments(with: self.paymentsRefs)
            let entries = try await entryDB.fetchEntries(with: self.entriesRefs)
            let evaluations = try await evaluationDB.fetchEvaluations(with: self.evaluationsRefs)
            let jointInvitedTasks = try await taskDB.fetchTasks(with: self.jointInvitedTasksRefs)
            let sharedInvitedTasks = try await taskDB.fetchTasks(with: self.sharedInvitedTasksRefs)
            let account = AccountStoreModel(
                recordName: self.recordName ?? "",
                personalTasks: personalTasks,
                jointTasks: jointTasks,
                sharedTasks: sharedTasks,
                payments: payments,
                entries: entries,
                evaluations: evaluations,
                jointInvitedTasks: jointInvitedTasks,
                sharedInvitedTasks: sharedInvitedTasks
            )
            return account
        } catch {
            return AccountStoreModel()
        }
    }
    
}
