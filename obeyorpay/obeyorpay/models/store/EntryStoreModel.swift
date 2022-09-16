//
//  EntryStoreModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


class EntryStoreModel: Identifiable, Equatable, Hashable {
    
    // conforms to Equatable
    static func == (lhs: EntryStoreModel, rhs: EntryStoreModel) -> Bool {
        return (lhs.recordName == rhs.recordName) &&
        (lhs.user == rhs.user) &&
        (lhs.taskRef == rhs.taskRef) &&
        (lhs.timestamp == rhs.timestamp)
    }
    
    // conforms to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordName)
        hasher.combine(user)
        hasher.combine(taskRef)
        hasher.combine(timestamp)
    }
    
    var recordName: String?
    var user: UserStoreModel
    var taskRef: String
    var timestamp: Date
    
    init() {
        self.recordName = nil
        self.user = UserStoreModel()
        self.taskRef = ""
        self.timestamp = Date()
    }
    
    init(
        user: MainUserStoreModel,
        task: TaskStoreModel
    ) {
        self.recordName = nil
        self.user = user.toUser()
        self.taskRef = task.recordName!
        self.timestamp = Date()
    }
    
    init(
        recordName: String,
        user: UserStoreModel,
        taskRef: String,
        timestamp: Date
    ) {
        self.recordName =  recordName
        self.user = user
        self.taskRef = taskRef
        self.timestamp = timestamp
    }
    
    func toCK() -> EntryCKModel {
        return EntryCKModel(
            recordName: self.recordName ?? "",
            userRef: self.user.recordName!,
            taskRef: self.taskRef,
            timestamp: self.timestamp
        )
    }
}
