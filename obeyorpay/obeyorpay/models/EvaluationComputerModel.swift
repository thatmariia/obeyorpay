//
//  EvaluationComputerModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 16/09/2022.
//

import Foundation


class EvaluationComputerModel {
    
    func foo(task: TaskStoreModel) {
        // get last period start date
        // get span
        // computed all last period start dates to start counting from
        // for each period, get relevant entries
        // compare the number of them to the target
        
        // TODO:: reset current count
    }
    
    func createNewEvaluations(task: TaskStoreModel, account: AccountStoreModel, signedInUser: SignedInUserModel) throws {
        var lastStartDate = task.lastPeriodStartDate
        if lastStartDate > Date() {
            return
        }
        
        var newEvaluations: [EvaluationStoreModel] = []
        var stop = false
        
        while(!stop) {
            // check if we have evaluation for this date
            let evaluations = account.evaluations.filter {
                ($0.taskRef == task.recordName!) &&
                ($0.periodStartDate == lastStartDate)
            }
            
            // if we don't, see if the date expired
            if evaluations.count != 0 {
                
                var endDate = getEndDate(startDate: lastStartDate, span: task.span)
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
                    newEvaluations.append(evaluation)
                    
                    // ading the evaluation to the database
                    let group = DispatchGroup()
                    group.enter()
                    DispatchQueue.global(qos: .default).async {
                        Task.init {
                            do {
                                // add the evaluation to the database
                                let evaluation = try await evaluationDB.addEvaluation(evaluation: evaluation)
                                
                                // TODO: add the evaluation to the task
                                
                                // TODO: add the evaluation to account
                                
                                // TODO: add evaluation to entry?
                                
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
            }
        }
    }
    
}
