//
//  EntrySettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import Foundation


class EntrySettingsModel {
    
    func addEntry(entry: EntryStoreModel, task: TaskStoreModel, taskType: TaskTypes, signedInUser: SignedInUserModel) throws {
        
        let group = DispatchGroup()
        group.enter()
        
        let updatedUser = signedInUser.user
        
        DispatchQueue.global(qos: .default).async {
            Task.init {
                do {
                    // adding new entry
                    ///task.currentCount += 1
                    let newEntry = try await entryDB.addEntry(entry: entry)
                    /// task.entriesRefs.append(newEntry.recordName!)
                    
                    // add entry to the account's task
                    if let taskIndex = updatedUser.account.tasks[taskType]!.firstIndex(where: { $0.recordName == task.recordName }) {
                        updatedUser.account.tasks[taskType]![taskIndex].currentCount += 1
                        updatedUser.account.tasks[taskType]![taskIndex].entriesRefs.append(newEntry.recordName!)
                    }
                    
                    // adding entry to the account
                    updatedUser.account.entries.append(newEntry)
                    try await accountDB.changeAccountVoid(with: updatedUser.account.recordName!, to: updatedUser.account)
                    
                    // adding entries to the task
                    try await taskDB.changeTaskVoid(with: task.recordName!, to: task)
                    
                    group.leave()
                } catch let err {
                    throw err
                }
            }
        }
        
        group.wait()
        
        signedInUser.user = updatedUser
    }
    
    func deleteLastEntry(from task: TaskStoreModel, taskType: TaskTypes, signedInUser: SignedInUserModel) throws {
        let entriesRefs = task.entriesRefs
        let entries = signedInUser.user.account.entries
            .filter {
                entriesRefs.contains($0.recordName!)
            }
            .sorted {
                $0.timestamp > $1.timestamp
            }
        
        if let lastEntry = entries.first {
            
            let group = DispatchGroup()
            group.enter()
            
            if (lastEntry.timestamp > task.lastPeriodStartDate) {
                if (task.currentCount > 0) {
                    task.currentCount -= 1
                }
            } else {
                return
            }
            if let entryTaskIndex = task.entriesRefs.firstIndex(where: { $0 == lastEntry.recordName }) {
                task.entriesRefs.remove(at: entryTaskIndex)
            }
            
            let updatedUser = signedInUser.user
            
            DispatchQueue.global(qos: .default).async {
                Task.init {
                    do {
                        // removing entry from task
                        try await taskDB.changeTaskVoid(with: task.recordName!, to: task)
                        
                        
                        // removing entry from the account's task
                        ///let updatedUser = signedInUser.user
                        if let taskIndex = updatedUser.account.tasks[taskType]!.firstIndex(where: { $0.recordName == task.recordName }) {
                            if let entryTaskIndex = updatedUser.account.tasks[taskType]![taskIndex].entriesRefs.firstIndex(where: { $0 == lastEntry.recordName }) {
                                updatedUser.account.tasks[taskType]![taskIndex].entriesRefs.remove(at: entryTaskIndex)
                            }
                        }
                        
                        // removing entry from account
                        if let entryAccountIndex = updatedUser.account.entries.firstIndex(where: { $0.recordName == lastEntry.recordName }) {
                            updatedUser.account.entries.remove(at: entryAccountIndex)
                        }
                        ///signedInUser.user = updatedUser
                        
                        try await accountDB.changeAccountVoid(with: updatedUser.account.recordName!, to: updatedUser.account)
                        
                        // removing entry
                        try await entryDB.deleteEntry(with: lastEntry.recordName!)
                        
                        group.leave()
                        
                    } catch let err {
                        throw err
                    }
                }
            }
            
            group.wait()
            
            signedInUser.user = updatedUser
            
        }
        
        
    }
}
