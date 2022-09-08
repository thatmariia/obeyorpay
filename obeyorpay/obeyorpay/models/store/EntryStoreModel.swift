//
//  EntryStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class EntryStoreModel {
    
    var recordName: String?
    var user: UserStoreModel
    var task: TaskStoreModel
    var timestamp: Date
    var evaluation: EvaluationStoreModel
    
    init() {
        self.recordName = nil
        self.user = UserStoreModel()
        self.task = TaskStoreModel()
        self.timestamp = Date()
        self.evaluation = EvaluationStoreModel()
    }
}