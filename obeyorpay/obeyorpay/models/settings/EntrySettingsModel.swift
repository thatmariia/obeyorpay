//
//  EntrySettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import Foundation


class EntrySettingsModel {
    
    func addEntry(entry: EntryStoreModel, task: TaskStoreModel, taskType: TaskTypes, signedInUser: SignedInUserModel) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
                    // adding new entry
                    task.currentCount += 1
                    let newEntry = try await entryDB.addEntry(entry: entry)
                    task.entriesRefs.append(newEntry.recordName!)
                    
                    // add entry to the account's task
                    let updatedUser = signedInUser.user
                    if let taskIndex = updatedUser.account.tasks[taskType]!.firstIndex(where: { $0.recordName == task.recordName }) {
                        updatedUser.account.tasks[taskType]![taskIndex].entriesRefs.append(newEntry.recordName!)
                    }
                    
                    // adding entry to the account
                    updatedUser.account.entries.append(newEntry)
                    signedInUser.user = updatedUser
                    let _ = try await accountDB.changeAccount(with: updatedUser.account.recordName!, to: updatedUser.account)
                    
                    // adding entries to the task
                    let _ = try await taskDB.changeTask(with: task.recordName!, to: task)
                    
                } catch let err {
                    throw err
                }
            }
        }
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
            DispatchQueue.main.async {
                Task.init {
                    do {
                        // removing entry from task
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
                        let _ = try await taskDB.changeTask(with: task.recordName!, to: task)
                        
                        
                        // removing entry from the account's task
                        let updatedUser = signedInUser.user
                        if let taskIndex = updatedUser.account.tasks[taskType]!.firstIndex(where: { $0.recordName == task.recordName }) {
                            if let entryTaskIndex = updatedUser.account.tasks[taskType]![taskIndex].entriesRefs.firstIndex(where: { $0 == lastEntry.recordName }) {
                                updatedUser.account.tasks[taskType]![taskIndex].entriesRefs.remove(at: entryTaskIndex)
                            }
                        }
                        
                        // removing entry from account
                        if let entryAccountIndex = updatedUser.account.entries.firstIndex(where: { $0.recordName == lastEntry.recordName }) {
                            updatedUser.account.entries.remove(at: entryAccountIndex)
                        }
                        signedInUser.user = updatedUser
                        
                        let _ = try await accountDB.changeAccount(with: updatedUser.account.recordName!, to: updatedUser.account)
                        
                        // removing entry
                        let _ = try await entryDB.deleteEntry(with: lastEntry.recordName!)
                    } catch let err {
                        throw err
                    }
                }
            }
            
        }
        
        
    }
}
