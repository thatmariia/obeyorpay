//
//  CKDataTaskModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation
import CloudKit

class CKTaskModel: CKModel {
    
    // MARK: - record modifications
    
    func fromTaskToCKRecord(from task: AnyObject, to record: CKRecord) -> CKRecord {
        let task = task as! TaskModel
        record[TaskModelKeys.title.rawValue]                    = task.title                    as CKRecordValue
        record[TaskModelKeys.creatorUserRef.rawValue]           = task.creatorUserRef           as CKRecordValue
        record[TaskModelKeys.createdDate.rawValue]              = task.createdDate              as CKRecordValue
        record[TaskModelKeys.jointUsersRefs.rawValue]           = task.jointUsersRefs           as CKRecordValue
        record[TaskModelKeys.sharedUsersRefs.rawValue]          = task.sharedUsersRefs          as CKRecordValue
        record[TaskModelKeys.span.rawValue]                     = task.span.toInt()             as CKRecordValue
        record[TaskModelKeys.spanStartDate.rawValue]            = task.spanStartDate            as CKRecordValue
        record[TaskModelKeys.lastPeriodStartDate.rawValue]      = task.lastPeriodStartDate      as CKRecordValue
        record[TaskModelKeys.countCost.rawValue]                = task.countCost                as CKRecordValue
        record[TaskModelKeys.entriesRefs.rawValue]              = task.entriesRefs              as CKRecordValue
        record[TaskModelKeys.trackBeforeStart.rawValue]         = task.trackBeforeStart.toInt() as CKRecordValue
        record[TaskModelKeys.paymentsRefs.rawValue]             = task.paymentsRefs             as CKRecordValue
        record[TaskModelKeys.target.rawValue]                   = task.target                   as CKRecordValue
        record[TaskModelKeys.currentCount.rawValue]             = task.currentCount             as CKRecordValue
        record[TaskModelKeys.evaluationsRefs.rawValue]          = task.evaluationsRefs          as CKRecordValue
        record[TaskModelKeys.color.rawValue]                    = task.color                    as CKRecordValue
        record[TaskModelKeys.build.rawValue]                    = task.build                    as CKRecordValue
        record[TaskModelKeys.jointInvitedUsersRefs.rawValue]    = task.jointInvitedUsersRefs    as CKRecordValue
        record[TaskModelKeys.sharedInvitedUsersRefs.rawValue]   = task.sharedInvitedUsersRefs   as CKRecordValue
        return record
    }
    
    func fromCKRecordToTask(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        guard let title                     = record[TaskModelKeys.title.rawValue]                  as? String      else { return nil }
        guard let creatorUserRef            = record[TaskModelKeys.creatorUserRef.rawValue]         as? String      else { return nil }
        guard let createdDate               = record[TaskModelKeys.createdDate.rawValue]            as? Date        else { return nil }
        guard let jointUsersRefs            = record[TaskModelKeys.jointUsersRefs.rawValue]         as? [String]    else { return nil }
        guard let sharedUsersRefs           = record[TaskModelKeys.sharedUsersRefs.rawValue]        as? [String]    else { return nil }
        guard let span                      = record[TaskModelKeys.span.rawValue]                   as? Int         else { return nil }
        guard let spanStartDate             = record[TaskModelKeys.spanStartDate.rawValue]          as? Date        else { return nil }
        guard let lastPeriodStartDate       = record[TaskModelKeys.lastPeriodStartDate.rawValue]    as? Date        else { return nil }
        guard let countCost                 = record[TaskModelKeys.countCost.rawValue]              as? Double      else { return nil }
        guard let entriesRefs               = record[TaskModelKeys.entriesRefs.rawValue]            as? [String]    else { return nil }
        guard let trackBeforeStart          = record[TaskModelKeys.trackBeforeStart.rawValue]       as? Int         else { return nil }
        guard let paymentsRefs              = record[TaskModelKeys.paymentsRefs.rawValue]           as? [String]    else { return nil }
        guard let target                    = record[TaskModelKeys.target.rawValue]                 as? Int         else { return nil }
        guard let currentCount              = record[TaskModelKeys.currentCount.rawValue]           as? Int         else { return nil }
        guard let evaluationsRefs           = record[TaskModelKeys.evaluationsRefs.rawValue]        as? [String]    else { return nil }
        guard let color                     = record[TaskModelKeys.color.rawValue]                  as? Int         else { return nil }
        guard let build                     = record[TaskModelKeys.build.rawValue]                  as? Int         else { return nil }
        guard let jointInvitedUsersRefs     = record[TaskModelKeys.jointInvitedUsersRefs.rawValue]  as? [String]    else { return nil }
        guard let sharedInvitedUsersRefs    = record[TaskModelKeys.sharedInvitedUsersRefs.rawValue] as? [String]    else { return nil }
        let task = TaskModel(
            recordName: recordName,
            title: title,
            creatorUserRef: creatorUserRef,
            createdDate: createdDate,
            jointUsersRefs: jointUsersRefs,
            sharedUsersRefs: sharedUsersRefs,
            span: span.toTaskSpan(),
            spanStartDate: spanStartDate,
            lastPeriodStartDate: lastPeriodStartDate,
            countCost: countCost,
            entriesRefs: entriesRefs,
            trackBeforeStart: trackBeforeStart.toBool(),
            paymentsRefs: paymentsRefs,
            target: target,
            currentCount: currentCount,
            evaluationsRefs: evaluationsRefs,
            color: color,
            build: build.toBool(),
            jointInvitedUsersRefs: jointInvitedUsersRefs,
            sharedInvitedUsersRefs: sharedInvitedUsersRefs
        )
        return task
    }
    
    // MARK: - database actions
}
