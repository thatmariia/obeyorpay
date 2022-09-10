//
//  CKTaskManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation
import CloudKit

class CKTaskManager: CKManager {
    
    // MARK: - record modifications
    
    func fromTaskToCKRecord(from task: AnyObject, to record: CKRecord) -> CKRecord {
        let task = task as! TaskCKModel
        record[TaskCKKeys.title.rawValue]                    = task.title                    as CKRecordValue
        record[TaskCKKeys.creatorUserRef.rawValue]           = task.creatorUserRef           as CKRecordValue
        record[TaskCKKeys.createdDate.rawValue]              = task.createdDate              as CKRecordValue
        record[TaskCKKeys.jointUsersRefs.rawValue]           = task.jointUsersRefs           as CKRecordValue
        record[TaskCKKeys.sharedUsersRefs.rawValue]          = task.sharedUsersRefs          as CKRecordValue
        record[TaskCKKeys.span.rawValue]                     = task.span.toInt()             as CKRecordValue
        record[TaskCKKeys.spanStartDate.rawValue]            = task.spanStartDate            as CKRecordValue
        record[TaskCKKeys.lastPeriodStartDate.rawValue]      = task.lastPeriodStartDate      as CKRecordValue
        record[TaskCKKeys.countCost.rawValue]                = task.countCost                as CKRecordValue
        record[TaskCKKeys.entriesRefs.rawValue]              = task.entriesRefs              as CKRecordValue
        record[TaskCKKeys.trackBeforeStart.rawValue]         = task.trackBeforeStart.toInt() as CKRecordValue
        record[TaskCKKeys.paymentsRefs.rawValue]             = task.paymentsRefs             as CKRecordValue
        record[TaskCKKeys.target.rawValue]                   = task.target                   as CKRecordValue
        record[TaskCKKeys.currentCount.rawValue]             = task.currentCount             as CKRecordValue
        record[TaskCKKeys.evaluationsRefs.rawValue]          = task.evaluationsRefs          as CKRecordValue
        record[TaskCKKeys.color.rawValue]                    = task.color                    as CKRecordValue
        record[TaskCKKeys.build.rawValue]                    = task.build                    as CKRecordValue
        record[TaskCKKeys.jointInvitedUsersRefs.rawValue]    = task.jointInvitedUsersRefs    as CKRecordValue
        record[TaskCKKeys.sharedInvitedUsersRefs.rawValue]   = task.sharedInvitedUsersRefs   as CKRecordValue
        return record
    }
    
    func fromCKRecordToTask(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        let title                     = record[TaskCKKeys.title.rawValue]                  as? String
        let creatorUserRef            = record[TaskCKKeys.creatorUserRef.rawValue]         as? String
        let createdDate               = record[TaskCKKeys.createdDate.rawValue]            as? Date
        let jointUsersRefs            = record[TaskCKKeys.jointUsersRefs.rawValue]         as? [String]
        let sharedUsersRefs           = record[TaskCKKeys.sharedUsersRefs.rawValue]        as? [String]
        let span                      = record[TaskCKKeys.span.rawValue]                   as? Int
        let spanStartDate             = record[TaskCKKeys.spanStartDate.rawValue]          as? Date
        let lastPeriodStartDate       = record[TaskCKKeys.lastPeriodStartDate.rawValue]    as? Date
        let countCost                 = record[TaskCKKeys.countCost.rawValue]              as? Double
        let entriesRefs               = record[TaskCKKeys.entriesRefs.rawValue]            as? [String]
        let trackBeforeStart          = record[TaskCKKeys.trackBeforeStart.rawValue]       as? Int
        let paymentsRefs              = record[TaskCKKeys.paymentsRefs.rawValue]           as? [String]
        let target                    = record[TaskCKKeys.target.rawValue]                 as? Int
        let currentCount              = record[TaskCKKeys.currentCount.rawValue]           as? Int
        let evaluationsRefs           = record[TaskCKKeys.evaluationsRefs.rawValue]        as? [String]
        let color                     = record[TaskCKKeys.color.rawValue]                  as? Int
        let build                     = record[TaskCKKeys.build.rawValue]                  as? Int
        let jointInvitedUsersRefs     = record[TaskCKKeys.jointInvitedUsersRefs.rawValue]  as? [String]
        let sharedInvitedUsersRefs    = record[TaskCKKeys.sharedInvitedUsersRefs.rawValue] as? [String]
        let task = TaskCKModel(
            recordName: recordName,
            title: title!,
            creatorUserRef: creatorUserRef!,
            createdDate: createdDate!,
            jointUsersRefs: jointUsersRefs!,
            sharedUsersRefs: sharedUsersRefs ?? [],
            span: span!.toTaskSpan(),
            spanStartDate: spanStartDate!,
            lastPeriodStartDate: lastPeriodStartDate!,
            countCost: countCost!,
            entriesRefs: entriesRefs ?? [],
            trackBeforeStart: trackBeforeStart!.toBool(),
            paymentsRefs: paymentsRefs ?? [],
            target: target!,
            currentCount: currentCount!,
            evaluationsRefs: evaluationsRefs ?? [],
            color: color!,
            build: build!.toBool(),
            jointInvitedUsersRefs: jointInvitedUsersRefs ?? [],
            sharedInvitedUsersRefs: sharedInvitedUsersRefs ?? []
        )
        return task
    }
    
    // MARK: - database actions
    
    func addTask(task: TaskStoreModel) async throws -> TaskStoreModel {
        let task = task.toCK()
        do {
            let task = try await addObject(of: .task, object: task, fromObjectToCKRecord: fromTaskToCKRecord, fromCKRecordToObject: fromCKRecordToTask) as! TaskCKModel
            return await task.toStore()
        } catch let err {
            throw err
        }
    }
    
    func changeTask(with recordName: String, to task: TaskStoreModel) async throws -> TaskStoreModel {
        let task = task.toCK()
        do {
            // fetch record with id
            var record = try await fetchRecord(with: CKRecord.ID(recordName: recordName))
            // make changes
            record = fromTaskToCKRecord(from: task, to: record)
            // save changes
            let user = try await saveObject(of: record, fromCKRecordToObject: fromCKRecordToTask) as! TaskCKModel
            return await user.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchTask(with recordName: String) async throws -> TaskStoreModel {
        do {
            let task = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToTask) as! TaskCKModel
            return await task.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchTasks(with recordNames: [String]) async throws -> [TaskStoreModel] {
        do {
            let tasks = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToTask) as! [TaskCKModel]
            return await tasks.asyncMap { await $0.toStore() }
        } catch let err {
            throw err
        }
    }
    
    func deleteTask(with recordName: String) async throws {
        do {
            try await deleteObject(with: CKRecord.ID(recordName: recordName))
        } catch let err {
            throw err
        }
    }
}
