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
//        (lhs.personalTasks == rhs.personalTasks) &&
//        (lhs.jointTasks == rhs.jointTasks) &&
//        (lhs.sharedTasks == rhs.sharedTasks) &&
        (lhs.payments == rhs.payments) &&
        (lhs.entries == rhs.entries) &&
        (lhs.entries == rhs.entries) &&
        (lhs.evaluations == rhs.evaluations) &&
        (lhs.invitedTasks == rhs.invitedTasks)
//        (lhs.jointInvitedTasks == rhs.jointInvitedTasks) &&
//        (lhs.sharedInvitedTasks == rhs.sharedInvitedTasks)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(tasks)
//        hasher.combine(personalTasks)
//        hasher.combine(jointTasks)
//        hasher.combine(sharedTasks)
        hasher.combine(payments)
        hasher.combine(entries)
        hasher.combine(evaluations)
        hasher.combine(invitedTasks)
//        hasher.combine(jointInvitedTasks)
//        hasher.combine(sharedInvitedTasks)
    }
    
    var recordName: String?
    var tasks: [TaskTypes: [TaskStoreModel]]
//    var personalTasks: [TaskStoreModel]
//    var jointTasks: [TaskStoreModel]
//    var sharedTasks: [TaskStoreModel]
    var payments: [PaymentStoreModel]
    var entries: [EntryStoreModel]
    var evaluations: [EvaluationStoreModel]
    var invitedTasks: [TaskTypes: [TaskStoreModel]]
//    var jointInvitedTasks: [TaskStoreModel]
//    var sharedInvitedTasks: [TaskStoreModel]
    
    init() {
        self.recordName = nil
        self.tasks = [
            .personal: [],
            .joint: [],
            .shared: []
        ]
//        self.personalTasks = []
//        self.jointTasks = []
//        self.sharedTasks = []
        self.payments = []
        self.entries = []
        self.evaluations = []
        self.invitedTasks = [
            .personal: [],
            .joint: [],
            .shared: []
        ]
//        self.jointInvitedTasks = []
//        self.sharedInvitedTasks = []
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
//        self.personalTasks = personalTasks
//        self.jointTasks = jointTasks
//        self.sharedTasks = sharedTasks
        self.payments = payments
        self.entries = entries
        self.evaluations = evaluations
        self.invitedTasks = [
            .personal: [],
            .joint: jointInvitedTasks,
            .shared: sharedInvitedTasks
        ]
//        self.jointInvitedTasks = jointInvitedTasks
//        self.sharedInvitedTasks = sharedInvitedTasks
    }
    
    func toCK() -> AccountCKModel {
        return AccountCKModel(
            recordName: self.recordName ?? "",
//            personalTasksRefs: self.personalTasks.map { $0.recordName ?? "" },
//            jointTasksRefs: self.jointTasks.map { $0.recordName ?? "" },
//            sharedTasksRefs: self.sharedTasks.map { $0.recordName ?? "" },
            personalTasksRefs: self.tasks[.personal]!.map { $0.recordName ?? "" },
            jointTasksRefs: self.tasks[.joint]!.map { $0.recordName ?? "" },
            sharedTasksRefs: self.tasks[.shared]!.map { $0.recordName ?? "" },
            paymentsRefs: self.payments.map { $0.recordName ?? "" },
            entriesRefs: self.entries.map { $0.recordName ?? "" },
            evaluationsRefs: self.evaluations.map { $0.recordName ?? "" },
//            jointInvitedTasksRefs: self.jointInvitedTasks.map { $0.recordName ?? "" },
//            sharedInvitedTasksRefs: self.sharedInvitedTasks.map { $0.recordName ?? "" }
            jointInvitedTasksRefs: self.invitedTasks[.joint]!.map { $0.recordName ?? "" },
            sharedInvitedTasksRefs: self.invitedTasks[.shared]!.map { $0.recordName ?? "" }
        )
    }
}
