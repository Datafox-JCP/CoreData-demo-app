//
//  ContactsProvider.swift
//  CoreDataContacts
//
//  Created by Juan Hernandez Pazos on 12/01/23.
//

import Foundation
import CoreData

final class ContactsProvider {
    
    static let shared = ContactsProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ContactsDataModel")
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error \(error)")
            }
        }
    }
}
