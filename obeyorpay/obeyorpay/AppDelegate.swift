//
//  AppDelegate.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 13/09/2022.
//

import Foundation
import SwiftUI
import CloudKit
import UserNotifications


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var signedInUser = SignedInUserModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
            print("Requested remote notifications. Status: \(UIApplication.shared.isRegisteredForRemoteNotifications)")
        }
        //UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            print("Registered for Push notifications with token: \(deviceToken)")
        }
        
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Push subscription failed: \(error)")
        }
    

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        guard let notification = CKQueryNotification(fromRemoteNotificationDictionary: userInfo as! [String : NSObject]) else { return }
        
        DispatchQueue.main.async {
            Task.init {
                
                switch notification.subscriptionID {
                case subscriptionIDs.user:
                    do {
                        var updatedUser = self.signedInUser.user
                        updatedUser = try await mainUserDB.fetchMainUser(with: updatedUser.recordName!)
                        self.signedInUser.user = updatedUser
                    } catch let err {
                        
                    }
                    break
                case subscriptionIDs.account:
                    do {
                        let updatedUser = self.signedInUser.user
                        updatedUser.account = try await accountDB.fetchAccount(with: updatedUser.account.recordName!)
                        self.signedInUser.user = updatedUser
                    } catch let err {
                        
                    }
                    break
                default:
                    break
                }
            }
        }
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
//        subscriptionDB.unsubscribe(title: subscriptionIDs.user)
//        subscriptionDB.unsubscribe(title: subscriptionIDs.account)
    }
    
}
