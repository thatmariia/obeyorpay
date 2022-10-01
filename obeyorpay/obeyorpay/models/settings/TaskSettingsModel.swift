//
//  AddTaskSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation

enum TaskTitleComment: String {
    case minLength = "Task title should contain at least 1 character"
}

enum TaskTargetComment: String {
    case empty = "You cannot leave this area blank"
}

enum TaskCostComment: String {
    case empty = "You cannot leave this area blank"
    case notNumber = "Please enter a valid number"
}

enum InvitedUserComment: String {
    case emptyUsername = "The username cannot be empty"
    case notExist = "This user does not exist"
    case alreadyInvited = "This user has already been invited"
}

class TaskSettingsModel {
    
    // title
    var titleMinLength = 1
    
    // supporting
    var userFound = false
    var userInvited = false
    
    func leaveTask(task: TaskStoreModel, taskType: TaskTypes, taskUserType: TaskTypes, signedInUser: SignedInUserModel) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
            
                    // remove task from the user
                    let updatedUser = signedInUser.user
                    if let taskIndex = updatedUser.account.tasks[taskUserType]!.firstIndex(where: { $0.recordName == task.recordName }) {
                        updatedUser.account.tasks[taskUserType]!.remove(at: taskIndex)
                    }
                    signedInUser.user = updatedUser
                    try await accountDB.changeAccountVoid(with: updatedUser.account.recordName!, to: updatedUser.account)
                    
                    // remove user from the task
                    if let userIndex = task.users[taskType]!.firstIndex(where: { $0.recordName == signedInUser.user.recordName! }) {
                        task.users[taskType]?.remove(at: userIndex)
                    }
                    try await taskDB.changeTaskVoid(with: task.recordName!, to: task)
                    
                } catch let err {
                    throw err
                }
            }
        }
    }
    
    func editTask(signedInUser: SignedInUserModel, task: TaskStoreModel, taskType: TaskTypes) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
                    let updatedUser = signedInUser.user
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
    
    func acceptTask(task: TaskStoreModel, taskType: TaskTypes, signedInUser: SignedInUserModel) throws {
        
        DispatchQueue.main.async {
            Task.init {
                do {
                    let updatedUser = signedInUser.user
                    
                    // remove task from the user's list of invited tasks
                    if let taskIndex = updatedUser.account.invitedTasks[taskType]!.firstIndex(where: {$0.recordName == task.recordName!}) {
                        updatedUser.account.invitedTasks[taskType]!.remove(at: taskIndex)
                    }
                    // add task to the user's list of type tasks
                    updatedUser.account.tasks[taskType]!.append(task)
                    signedInUser.user = updatedUser
                    
                    // remove user from the task's list of invited type users
                    if let taskIndex = task.invitedUsers[taskType]!.firstIndex(where: {$0.recordName == signedInUser.user.recordName!}) {
                        task.invitedUsers[taskType]!.remove(at: taskIndex)
                    }
                    // add user to the task's list of type users
                    task.users[taskType]!.append(signedInUser.user.toUser())
                    let _ = try await taskDB.changeTask(with: task.recordName!, to: task)
                    
                    if taskType == .joint {
                        
                        // if user had this task in their shared tasks, remove it from there
                        let updatedUser = signedInUser.user
                        if let taskIndex = updatedUser.account.tasks[.shared]!.firstIndex(where: {$0.recordName == task.recordName!}) {
                            updatedUser.account.tasks[taskType]!.remove(at: taskIndex)
                        }
                        signedInUser.user = updatedUser
                        
                        // for every user that had this task in their personal tasks, move to joint
                        for user in task.users[.joint]! {
                            
                            // in the user, move task to joint
                            let updatedOtherUser = try await mainUserDB.fetchMainUser(with: user.recordName!)
                            if let taskIndex = updatedOtherUser.account.tasks[.personal]!.firstIndex(where: {$0.recordName == task.recordName!}) {
                                updatedOtherUser.account.tasks[.personal]!.remove(at: taskIndex)
                                updatedOtherUser.account.tasks[.joint]!.append(task)
                                let _ = try await accountDB.changeAccount(with: updatedOtherUser.account.recordName!, to: updatedOtherUser.account)
                            }
                        }
                        task.users[.personal] = []
                    }
                    
                    let _ = try await accountDB.changeAccount(with: updatedUser.account.recordName!, to: updatedUser.account)
                    
                } catch let err {
                    throw err
                }
            }
        }
    }
    
    func rejectTask(task: TaskStoreModel, taskType: TaskTypes, signedInUser: SignedInUserModel) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
                    // remove task from the list of invited to
                    let updatedUser = signedInUser.user
                    if let taskIndex = updatedUser.account.invitedTasks[taskType]!.firstIndex(where: {$0.recordName == task.recordName!}) {
                        updatedUser.account.invitedTasks[taskType]!.remove(at: taskIndex)
                    }
                    signedInUser.user = updatedUser
                    let _ = try await accountDB.changeAccount(with: updatedUser.account.recordName!, to: updatedUser.account)
                    
                    // remove user from the list of invited users to the task
                    if let userIndex = task.invitedUsers[taskType]!.firstIndex(where: {$0.recordName == signedInUser.user.recordName}) {
                        task.invitedUsers[taskType]!.remove(at: userIndex)
                    }
                    let _ = try await taskDB.changeTask(with: task.recordName!, to: task)
                } catch let err {
                    throw err
                }
            }
        }
        
    }
    
    func inviteUser(with username: String, to task: TaskStoreModel, taskUserType: TaskTypes, taskInvitedType: TaskTypes, signedInUser: SignedInUserModel) throws {
        DispatchQueue.main.async {
            Task.init {
                do {
                    // find main user with this username
                    let updatedInvitedUser = try await mainUserDB.queryMainUser(withKey: .username, .equal, to: username)
                    // envi change
                    let updatedUser = signedInUser.user
                    if let taskIndex = updatedUser.account.tasks[taskUserType]!.firstIndex(where: {$0.recordName == task.recordName!}) {
                        updatedUser.account.tasks[taskUserType]![taskIndex].invitedUsers[taskInvitedType]!.append(updatedInvitedUser.toUser())
                    } else {
                        // item could not be found
                    }
                    signedInUser.user = updatedUser
                    
                    // append task to user's account's invited list
                    updatedInvitedUser.account.invitedTasks[taskInvitedType]!.append(task)
                    let _ = try await accountDB.changeAccount(with: updatedInvitedUser.account.recordName!, to: updatedInvitedUser.account)
                    
                    // append user to task' invited list
                    let _ = try await taskDB.changeTask(with: task.recordName!, to: task)
                    
                } catch let err {
                    throw err
                }
            }
        }
    }
    
    func canInviteUser(username: String, task: TaskStoreModel, taskInvitedType: TaskTypes) -> CorrectnessComment {
        
        if username.count == 0 {
            return CorrectnessComment(isCorrect: false, note: InvitedUserComment.emptyUsername.rawValue)
        }
        
        // already exists
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global(qos: .userInitiated).async {
            Task.init {
                do {
                    self.userFound = false
                    self.userInvited = false
                    
                    let users = try await userDB.queryUsers(withKey: .username, .equal, to: username)
                    //let nrUsers = try await userDB.countUsers(with: username)
                    if users.count != 0 {
                        for user in users {
                            if task.invitedUsers[taskInvitedType]!.contains(user) {
                                self.userInvited = true
                                break
                            }
                        }
                        self.userFound = true
                    } else {
                        self.userInvited = false
                        self.userFound = false
                    }
                    
                    group.leave()
                } catch let err {

                }
            }
        }
        
        group.wait()
        
        if !userFound {
            return CorrectnessComment(isCorrect: false, note: InvitedUserComment.notExist.rawValue)
        }
        
        if userInvited {
            return CorrectnessComment(isCorrect: false, note: InvitedUserComment.alreadyInvited.rawValue)
        }
        
        // all good
        return CorrectnessComment(isCorrect: true, note: "")
    }
    
    func addTask(signedInUser: SignedInUserModel, task: TaskStoreModel) throws {
        let group = DispatchGroup()
        group.enter()
        
        let updatedUser = signedInUser.user
        
        DispatchQueue.global(qos: .userInitiated).async {
            Task.init {
                do {
                    // adding new task
                    let newTask = try await taskDB.addTask(task: task)
                    updatedUser.account.tasks[.personal]!.append(newTask)
                    
                    // adding task to personal tasks of user
                    updatedUser.account = try await accountDB.changeAccount(with: updatedUser.account.recordName!, to: updatedUser.account)
                    
                    group.leave()
                } catch let err {
                    throw err
                }
            }
        }
        
        group.wait()
        
        signedInUser.user = updatedUser
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
