//
//  CDDataUserModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 06/09/2022.
//

import Foundation
import CoreData
import SwiftUI

//class CDUserModel {
//    var uid: String
//}

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
            print("*_*_*_*_*_* trying to save, changed? ", managedObjectContext.hasChanges)
            try managedObjectContext.save()
        } catch let err {
            print(":(", err.localizedDescription)
        }
    }
    
    private func fetchCDEntity() -> [CDUser] {
        let fetchRequest: NSFetchRequest<CDUser>
        fetchRequest = CDUser.fetchRequest()
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            print("*_*_*_*_*_* fetched objects: \(objects)")
            return objects
        } catch let err {
            print("*_*_*_*_*_* :(", err.localizedDescription)
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
    
    func addUser(with uid: String) {
        let userObject = CDUser(context: managedObjectContext)
        userObject.uid = uid
        
        saveContext()
    }
    
}
