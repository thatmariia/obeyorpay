//
//  CKSubscriptionsManager.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 13/09/2022.
//

import Foundation
import CloudKit


class CKSubscriptionsID {
    let account = "Account Changes " + UUID().uuidString
    let user = "User Changes " + UUID().uuidString
}

class CKSubscriptionsManager {
    
    func unsubscribe(title: String) {
        let oldOperation = CKModifySubscriptionsOperation(subscriptionsToSave: [], subscriptionIDsToDelete: [title])
        oldOperation.qualityOfService = .userInteractive
        globalDB.publicDB.add(oldOperation)
    }
    
    func subscribeToChanges(
        recordType: CKRecordType,
        predicate: NSPredicate,
        title: String,
        successAction: @escaping () -> Void
    ) {
        // UserDefaults.standard.setValue(false, forKey: "didCreateQuerySubscription\(title)")
        // Only proceed if you need to create the subscription.
        guard !UserDefaults.standard.bool(forKey: "didCreateQuerySubscription\(title)") else {  return }
        
        let subscription = CKQuerySubscription(recordType: recordType.rawValue,
                                               predicate: predicate,
                                               subscriptionID: title,
                                               options: [.firesOnRecordUpdate])
        

        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.shouldSendContentAvailable = true
        subscription.notificationInfo = notificationInfo
        
        // Save the subscription to the server.
        
        let operation = CKModifySubscriptionsOperation(
            subscriptionsToSave: [subscription]
        )
        
        operation.modifySubscriptionsResultBlock = { result in
            switch result {
            case .success:
                // Record that the system successfully creates the subscription
                // to prevent unnecessary trips to the server in later launches.
                UserDefaults.standard.setValue(true, forKey: "didCreateQuerySubscription\(title)")

                print("we're actually here!! \(title)")
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
        
        
        
        operation.qualityOfService = .userInteractive
        globalDB.publicDB.add(operation)
//        DispatchQueue.main.async {
//            Task.init {
//                do {
//                    try await globalDB.publicDB.save(subscription)
//                    print("saved")
//                } catch let err {
//                    print("**** :(", err.localizedDescription)
//                }
//            }
//        }
    }
    
    func subscribe(signedInUser: SignedInUserModel) {
        //https://developer.apple.com/documentation/cloudkit/ckquerysubscription
        
        let predicateAccount = NSPredicate(format: "recordID == %@", CKRecord.Reference(recordID: CKRecord.ID(recordName: signedInUser.user.account.recordName!), action: .none))
        subscribeToChanges(recordType: .account, predicate: predicateAccount, title: "AccountChanges") {
    
        }
        
        let predicateUser = NSPredicate(format: "%K == %@", "recordID", CKRecord.Reference(recordID: CKRecord.ID(recordName: signedInUser.user.recordName!), action: .none))
        subscribeToChanges(recordType: .user, predicate: predicateUser, title: subscriptionIDs.user) {
            
        }
    }
}
