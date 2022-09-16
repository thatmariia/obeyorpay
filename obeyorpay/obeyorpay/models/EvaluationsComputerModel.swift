//
//  EvaluationComputerModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import Foundation


class EvaluationsComputerModel {
    
    // supporting
    var newEvaluations: [EvaluationStoreModel] = []
    var allNewEvaluations: [TaskStoreModel: (TaskTypes, [EvaluationStoreModel])] = [:]
    
    func computeNewEvaluations(signedInUser: SignedInUserModel) {
        self.allNewEvaluations = [:]
        
        // creating new evaluations for personal and joint tasks
        for task in signedInUser.user.account.tasks[.personal]! {
            do {
                try self.createNewEvaluations(task: task, account: signedInUser.user.account)
                self.allNewEvaluations[task] = (TaskTypes.personal, newEvaluations)
            } catch {}
        }
        for task in signedInUser.user.account.tasks[.joint]! {
            do {
                try self.createNewEvaluations(task: task, account: signedInUser.user.account)
                self.allNewEvaluations[task] = (TaskTypes.joint, newEvaluations)
            } catch {}
        }
        
        // adding evaluations to account
        self.updateAccount(signedInUser: signedInUser)
        
        
        // adding evaluations to the task
        self.updateTasks(signedInUser: signedInUser)
        
        
        // TODO:: reset current count
    }
    
    private func updateTasks(signedInUser: SignedInUserModel) {
        for (task, (taskType, evaluations)) in self.allNewEvaluations {
            let group = DispatchGroup()
            group.enter()
            DispatchQueue.global(qos: .default).async {
                Task.init {
                    do {
                        // adding relevant evaluations to the task - locally
                        let updatedTask = task
                        updatedTask.evaluationsRefs += evaluations.map { $0.recordName! }
                        
                        // changing the task in the account - locally
                        if let taskIndex = signedInUser.user.account.tasks[taskType]!.firstIndex(where: { $0.recordName == task.recordName }) {
                            signedInUser.user.account.tasks[taskType]![taskIndex] = task
                        }
                        
                        // adding relevant evaluations to the task - db
                        try await taskDB.changeTaskVoid(with: task.recordName!, to: updatedTask)
                        
                        // changing the task in the account - db
                        // TODO: do we need to do that?
                        try await accountDB.changeAccountVoid(with: signedInUser.user.account.recordName!, to: signedInUser.user.account)
                        
                        group.leave()
                    } catch {}
                }
            }
            group.wait()
        }
    }
    
    private func updateAccount(signedInUser: SignedInUserModel) {
        
        // update locally
        let evaluationsFromAllNewEvaluations = allNewEvaluations.values.map { $0.1 }
        signedInUser.user.account.evaluations += Array(evaluationsFromAllNewEvaluations.joined())
        
        // update in db
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global(qos: .default).async {
            Task.init {
                do {
                    let _ = try await accountDB.changeAccount(with: signedInUser.user.account.recordName!, to: signedInUser.user.account)
                    group.leave()
                } catch {}
            }
        }
        group.wait()
        
    }
    
    private func createNewEvaluations(task: TaskStoreModel, account: AccountStoreModel) throws {
        var lastStartDate = task.lastPeriodStartDate
        if lastStartDate > Date() {
            return
        }
        
        self.newEvaluations = []
        var stop = false
        
        while(!stop) {
            // check if we have evaluation for this date
            let evaluations = account.evaluations.filter {
                ($0.taskRef == task.recordName!) &&
                ($0.periodStartDate == lastStartDate)
            }
            
            // if we don't, see if the date expired
            if evaluations.count != 0 {
                
                let endDate = getEndDate(startDate: lastStartDate, span: task.span)
                // if the task span is not ongoing
                if endDate < Date() {
                    
                    // evaluating the period between lastStartDate and endDate
                    
                    let relevantEntries = account.entries.filter {
                        ($0.taskRef == task.recordName!) &&
                        ($0.timestamp > lastStartDate) &&
                        ($0.timestamp <= endDate)
                    }
                    
                    var totalCost = 0.0
                    if task.build {
                        // if the target is "at least"
                        totalCost = task.countCost * Double(task.target - min(task.target, relevantEntries.count))
                    } else {
                        // if the target is "at most"
                        totalCost = task.countCost * Double(max(task.target, relevantEntries.count) - task.target)
                    }
                    // everyone pays equally
                    //let costPerPerson = totalCost / Double(task.users[.joint]!.count)
                    
                    // creating a new evaluation
                    let evaluation = EvaluationStoreModel(
                        periodStartDate: lastStartDate,
                        periodEndDate: endDate,
                        jointUsers: task.users[.joint]!,
                        taskRef: task.recordName!,
                        count: relevantEntries.count,
                        target: task.target,
                        totalCost: totalCost,
                        build: task.build
                    )
                    
                    // ading the evaluation to the database
                    let group = DispatchGroup()
                    group.enter()
                    DispatchQueue.global(qos: .default).async {
                        Task.init {
                            do {
                                // add the evaluation to the database
                                let evaluation = try await evaluationDB.addEvaluation(evaluation: evaluation)
                                self.newEvaluations.append(evaluation)
                                
                                group.leave()
                            } catch let err {
                                throw err
                            }
                        }
                    }
                    group.wait()
                    
                    // updating lastStartDate
                    lastStartDate = endDate
                    
                } else {
                    stop = true
                }
            } else {
                stop = true
            }
        }
    }
    
}
