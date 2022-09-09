//
//  AddTaskSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation

enum TaskTitleComment: String {
    case minLength = "Task title should contain at least 1 charatcer"
}

enum TaskTargetComment: String {
    case empty = "You cannot leave this area blank"
}

enum TaskCostComment: String {
    case empty = "You cannot leave this area blank"
    case notNumber = "Please enter a valid number"
}

class TaskSettingsModel {
    
    // title
    var titleMinLength = 1
    
    func editTask(signedInUser: SignedInUserModel, task: TaskStoreModel, taskType: TaskTypes) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
                    let updatedUser = signedInUser.user
                    // updatedUser.account.tasks[taskType]
                    let updatedTask = try await taskDB.changeTask(with: task.recordName!, to: task)
                    if let taskIndex = updatedUser.account.tasks[taskType]!.firstIndex(where: {$0.recordName == task.recordName!}) {
                        updatedUser.account.tasks[taskType]![taskIndex] = updatedTask
                    } else {
                        // item could not be found
                    }
                    signedInUser.user = updatedUser
                } catch let err {
                    throw err
                }
            }
        }
    }
    
    func addTask(signedInUser: SignedInUserModel, task: TaskStoreModel) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
                    // adding new task
                    let newTask = try await taskDB.addTask(task: task)
                    let updatedUser = signedInUser.user
                    updatedUser.account.tasks[.personal]!.append(newTask)
                    // adding task to personal tasks of user
                    updatedUser.account = try await accountDB.changeAccount(with: updatedUser.account.recordName!, to: updatedUser.account)
                    signedInUser.user = updatedUser
                } catch let err {
                    throw err
                }
            }
        }
    }
    
    
    func isTitleCorrect(title: String) -> CorrectnessComment {
        // min length - not met
        if title.count < self.titleMinLength {
            return CorrectnessComment(isCorrect: false, note: TaskTitleComment.minLength.rawValue)
        }
        // all good
        return CorrectnessComment(isCorrect: true, note: "")
    }
    
    func isTargetCorrect(target: String) -> CorrectnessComment {
        // empty string
        if target.count == 0 {
            return CorrectnessComment(isCorrect: false, note: TaskTargetComment.empty.rawValue)
        }
        // all good
        return CorrectnessComment(isCorrect: true, note: "")
    }
    
    func isCostCorrect(countCost: String) -> CorrectnessComment {
        // empty string
        if countCost.count == 0 {
            return CorrectnessComment(isCorrect: false, note: TaskCostComment.empty.rawValue)
        }
        
        // not a number
        let number = Double(countCost.replacingOccurrences(of: ",", with: "."))
        if number == nil {
            return CorrectnessComment(isCorrect: false, note: TaskCostComment.notNumber.rawValue)
        }
        
        // all good
        return CorrectnessComment(isCorrect: true, note: "")
    }
}
