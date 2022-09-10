//
//  AccountStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class AccountStoreModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: AccountStoreModel, rhs: AccountStoreModel) -> Bool {
        return (lhs.recordName == rhs.recordName) &&
        (lhs.tasks == rhs.tasks) &&
        (lhs.payments == rhs.payments) &&
        (lhs.entries == rhs.entries) &&
        (lhs.entries == rhs.entries) &&
        (lhs.evaluations == rhs.evaluations) &&
        (lhs.invitedTasks == rhs.invitedTasks)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(tasks)
        hasher.combine(payments)
        hasher.combine(entries)
        hasher.combine(evaluations)
        hasher.combine(invitedTasks)
    }
    
    var recordName: String?
    var tasks: [TaskTypes: [TaskStoreModel]]
    var payments: [PaymentStoreModel]
    var entries: [EntryStoreModel]
    var evaluations: [EvaluationStoreModel]
    var invitedTasks: [TaskTypes: [TaskStoreModel]]
    
    init() {
        self.recordName = nil
        self.tasks = [
            .personal: [],
            .joint: [],
            .shared: []
        ]
        self.payments = []
        self.entries = []
        self.evaluations = []
        self.invitedTasks = [
            .personal: [],
            .joint: [],
            .shared: []
        ]
    }
    
    init(
        recordName: String,
        personalTasks: [TaskStoreModel],
        jointTasks: [TaskStoreModel],
        sharedTasks: [TaskStoreModel],
        payments: [PaymentStoreModel],
        entries: [EntryStoreModel],
        evaluations: [EvaluationStoreModel],
        jointInvitedTasks: [TaskStoreModel],
        sharedInvitedTasks: [TaskStoreModel]
    ) {
        self.recordName = recordName
        self.tasks = [
            .personal: personalTasks,
            .joint: jointTasks,
            .shared: sharedTasks
        ]
        self.payments = payments
        self.entries = entries
        self.evaluations = evaluations
        self.invitedTasks = [
            .personal: [],
            .joint: jointInvitedTasks,
            .shared: sharedInvitedTasks
        ]
    }
    
    func toCK() -> AccountCKModel {
        return AccountCKModel(
            recordName: self.recordName ?? "",
            personalTasksRefs: self.tasks[.personal]!.map { $0.recordName ?? "" },
            jointTasksRefs: self.tasks[.joint]!.map { $0.recordName ?? "" },
            sharedTasksRefs: self.tasks[.shared]!.map { $0.recordName ?? "" },
            paymentsRefs: self.payments.map { $0.recordName ?? "" },
            entriesRefs: self.entries.map { $0.recordName ?? "" },
            evaluationsRefs: self.evaluations.map { $0.recordName ?? "" },
            jointInvitedTasksRefs: self.invitedTasks[.joint]!.map { $0.recordName ?? "" },
            sharedInvitedTasksRefs: self.invitedTasks[.shared]!.map { $0.recordName ?? "" }
        )
    }
}
