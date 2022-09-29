//
//  CDDataUserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CoreData
import SwiftUI


class CDDataUserModel {
    let container: NSPersistentContainer
    let managedObjectContext: NSManagedObjectContext
    // let userEntity: NSEntityDescription
    
    init() {
        container = NSPersistentContainer(name: "obeyorpay")
        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        container.loadPersistentStores { description, err in
            if let err = err {
                print("Core Data failed to load: \(err.localizedDescription)")
                return
            }
        }
        
        managedObjectContext = container.viewContext
        // userEntity = NSEntityDescription.entity(forEntityName: "CDUser", in: managedObjectContext)!
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    private func fetchCDEntity() -> [CDUser] {
        let fetchRequest: NSFetchRequest<CDUser>
        fetchRequest = CDUser.fetchRequest()
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            return objects
        } catch let err {
            print(err.localizedDescription)
        }
        return []
    }
    
    func clearCDEntity() {
        let objects = fetchCDEntity()
        if objects.count > 0 {
            for object in objects {
                managedObjectContext.delete(object)
            }
            saveContext()
        }
    }
    
    func fetchUser() -> String? {
        let objects = fetchCDEntity()
        if objects.count == 0 {
            return nil
        }
        return objects.first?.uid
    }
    
    func fetchPaymentLink() -> String {
        let objects = fetchCDEntity()
        if let link = objects.first?.paymentLink {
            return link
        }
        return ""
    }
    
    func addUser(with uid: String, paymentLink: String = "") {
        let userObject = CDUser(context: managedObjectContext)
        userObject.uid = uid
        userObject.paymentLink = paymentLink
        
        saveContext()
    }
    
}
