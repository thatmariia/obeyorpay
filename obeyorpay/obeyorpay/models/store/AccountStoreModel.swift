//
//  AccountStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class AccountStoreModel{
    var personalTasks: [TaskStoreModel]
    var jointTasks: [TaskStoreModel]
    var sharedTasks: [TaskStoreModel]
    var payments: [PaymentStoreModel]
    var entries: [EntryStoreModel]
    var evaluations: [EvaluationStoreModel]
    var jointInvitedTasks: [TaskStoreModel]
    var sharedInvitedTasks: [TaskStoreModel]
    
    init() {
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
