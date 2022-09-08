//
//  CKEvaluationManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import Foundation
import CloudKit


class CKEvaluationManager: CKManager {
    
    // MARK: - record modifications
    
    func fromEvaluationToCKRecord(from evaluation: AnyObject, to record: CKRecord) -> CKRecord {
        let evaluation = evaluation as! EvaluationCKModel
        record[EvaluationCKKeys.periodStartDate.rawValue]   = evaluation.periodStartDate    as CKRecordValue
        record[EvaluationCKKeys.periodEndDate.rawValue]     = evaluation.periodEndDate      as CKRecordValue
        record[EvaluationCKKeys.jointUsersRefs.rawValue]    = evaluation.jointUsersRefs     as CKRecordValue
        record[EvaluationCKKeys.paymentsRefs.rawValue]      = evaluation.paymentsRefs       as CKRecordValue
        record[EvaluationCKKeys.taskRef.rawValue]           = evaluation.taskRef            as CKRecordValue
        record[EvaluationCKKeys.count.rawValue]             = evaluation.count              as CKRecordValue
        record[EvaluationCKKeys.target.rawValue]            = evaluation.target             as CKRecordValue
        record[EvaluationCKKeys.totalCost.rawValue]         = evaluation.totalCost          as CKRecordValue
        record[EvaluationCKKeys.build.rawValue]             = evaluation.build              as CKRecordValue
        return record
    }
    
    func fromCKRecordToEvaluation(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        guard let periodStartDate   = record[EvaluationCKKeys.periodStartDate.rawValue] as? Date        else { return nil }
        guard let periodEndDate     = record[EvaluationCKKeys.periodEndDate.rawValue]   as? Date        else { return nil }
        guard let jointUsersRefs    = record[EvaluationCKKeys.jointUsersRefs.rawValue]  as? [String]    else { return nil }
        guard let paymentsRefs      = record[EvaluationCKKeys.paymentsRefs.rawValue]    as? [String]    else { return nil }
        guard let taskRef           = record[EvaluationCKKeys.taskRef.rawValue]         as? String      else { return nil }
        guard let count             = record[EvaluationCKKeys.count.rawValue]           as? Int         else { return nil }
        guard let target            = record[EvaluationCKKeys.target.rawValue]          as? Int         else { return nil }
        guard let totalCost         = record[EvaluationCKKeys.totalCost.rawValue]       as? Double      else { return nil }
        guard let build             = record[EvaluationCKKeys.build.rawValue]           as? Int         else { return nil }
        let evaluation = EvaluationCKModel(
            recordName: recordName,
            periodStartDate: periodStartDate,
            periodEndDate: periodEndDate,
            jointUsersRefs: jointUsersRefs,
            paymentsRefs: paymentsRefs,
            taskRef: taskRef,
            count: count,
            target: target,
            totalCost: totalCost,
            build: build.toBool()
        )
        return evaluation
    }
    
    // MARK: - database actions
    
    func fetchEvaluation(with recordName: String) async throws -> EvaluationStoreModel {
        do {
            let evaluation = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToEvaluation) as! EvaluationCKModel
            return await evaluation.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchEvaluations(with recordNames: [String]) async throws -> [EvaluationStoreModel] {
        do {
            let evaluations = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToEvaluation) as! [EvaluationCKModel]
            return await evaluations.asyncMap { await $0.toStore() }
        } catch let err {
            throw err
        }
    }
    
}
