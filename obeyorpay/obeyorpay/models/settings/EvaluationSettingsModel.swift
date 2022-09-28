//
//  EvaluationSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import Foundation


class EvaluationSettingsModel {
    
    
    func pay(for evaluations: [EvaluationStoreModel], signedInUser: SignedInUserModel) throws {
        
        DispatchQueue.main.async {
            Task.init {
                for evaluation in evaluations {
                    
                    do {
                        // creating payment
                        let newPayment = PaymentStoreModel(
                            user: signedInUser.user.toUser(),
                            taskRef: evaluation.taskRef,
                            evaluationRef: evaluation.recordName!,
                            amount: evaluation.totalCost / Double(evaluation.jointUsers.count)
                        )
                        let payment = try await paymentDB.addPayment(payment: newPayment)
                        
                        // adding payment to account
                        let updatedUser = signedInUser.user
                        updatedUser.account.payments.append(payment)
                        
                        // adding payment to the evaluation & changing the evaluation in account
                        evaluation.paymentsRefs.append(payment.recordName!)
                        if let evaluationIndex = updatedUser.account.evaluations.firstIndex(where: { $0.recordName == evaluation.recordName }) {
                            updatedUser.account.evaluations[evaluationIndex] = evaluation
                        }
                        signedInUser.user = updatedUser
                        
                        try await accountDB.changeAccountVoid(with: updatedUser.account.recordName!, to: updatedUser.account)
                        try await evaluationDB.changeEvaluationVoid(with: evaluation.recordName!, to: evaluation)
                        
                    } catch let err {
                        throw err
                    }
                    
                }
            }
        }
    }
}
