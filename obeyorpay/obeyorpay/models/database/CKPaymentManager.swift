//
//  CKPaymentManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 08/09/2022.
//

import Foundation
import CloudKit


class CKPaymentManager: CKManager {
    
    // MARK: - record modifications
    
    func fromPaymentToCKRecord(from payment: AnyObject, to record: CKRecord) -> CKRecord {
        let payment = payment as! PaymentCKModel
        record[PaymentCKKeys.userRef.rawValue]          = payment.userRef       as CKRecordValue
        record[PaymentCKKeys.taskRef.rawValue]          = payment.taskRef       as CKRecordValue
        record[PaymentCKKeys.timestamp.rawValue]        = payment.timestamp     as CKRecordValue
        record[PaymentCKKeys.evaluationRef.rawValue]    = payment.evaluationRef as CKRecordValue
        record[PaymentCKKeys.amount.rawValue]           = payment.amount        as CKRecordValue
        return record
    }
    
    func fromCKRecordToPayment(from record: CKRecord) -> AnyObject? {
        let recordName = record.recordID.recordName
        let userRef       = record[PaymentCKKeys.userRef.rawValue]        as? String
        let taskRef       = record[PaymentCKKeys.taskRef.rawValue]        as? String
        let timestamp     = record[PaymentCKKeys.timestamp.rawValue]      as? Date
        let evaluationRef = record[PaymentCKKeys.evaluationRef.rawValue]  as? String
        let amount        = record[PaymentCKKeys.amount.rawValue]         as? Double
        let payment = PaymentCKModel(
            recordName: recordName,
            userRef: userRef!,
            taskRef: taskRef!,
            timestamp: timestamp!,
            evaluationRef: evaluationRef!,
            amount: amount!
        )
        return payment
    }
    
    // MARK: - database actions
    
    func fetchPayment(with recordName: String) async throws -> PaymentStoreModel {
        do {
            let payment = try await fetchObject(with: recordName, fromCKRecordToObject: fromCKRecordToPayment) as! PaymentCKModel
            return await payment.toStore()
        } catch let err {
            throw err
        }
    }
    
    func fetchPayments(with recordNames: [String]) async throws -> [PaymentStoreModel] {
        do {
            let payments = try await fetchObjects(with: recordNames.map { CKRecord.ID(recordName: $0) }, fromCKRecordToObject: fromCKRecordToPayment) as! [PaymentCKModel]
            return await payments.asyncMap { await $0.toStore() }
        } catch let err {
            throw err
        }
    }
    
    func addPayment(payment: PaymentStoreModel) async throws -> PaymentStoreModel {
        let payment = payment.toCK()
        do {
            let payment = try await addObject(of: .payment, object: payment, fromObjectToCKRecord: fromPaymentToCKRecord, fromCKRecordToObject: fromCKRecordToPayment) as! PaymentCKModel
            return await payment.toStore()
        } catch let err {
            throw err
        }
    }
}
