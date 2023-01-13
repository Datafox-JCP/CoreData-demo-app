//
//  Contact.swift
//  CoreDataContacts
//
//  Created by Juan Hernandez Pazos on 12/01/23.
//

import Foundation
import CoreData

final class Contact: NSManagedObject, Identifiable {
    
    @NSManaged var dob: Date
    @NSManaged var name: String
    @NSManaged var notes: String
    @NSManaged var phoneNumber: String
    @NSManaged var email: String
    @NSManaged var isFavorite: Bool
    
    var isValid: Bool {
        !name.isEmpty &&
        !phoneNumber.isEmpty &&
        !email.isEmpty
    }
    
    var isBirthday: Bool {
        Calendar.current.isDateInToday(dob)
    }
    
    var formattedName: String {
        "\(isBirthday ? "🎈" : "")\(name)"
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setValue(Date.now, forKey: "dob")
        setValue(false, forKey: "isFavorite")
    }
}

extension Contact {
    
    private static var contactsFetchRequest: NSFetchRequest<Contact> {
        NSFetchRequest(entityName: "Contact")
    }
    
    static func all() -> NSFetchRequest<Contact> {
        let request: NSFetchRequest<Contact> = contactsFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Contact.name, ascending: true)
        ]
        return request
    }
    
    static func filter(width config: SearchConfig) -> NSPredicate {
        switch config.filter {
        case .all:
            return config.query.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[cd] %@", config.query)
        case .fav:
            return config.query.isEmpty ? NSPredicate(format: "isFavorite == %@", NSNumber(value: true)) : NSPredicate(format: "name CONTAINS[cd] %@ AND isFavorite == %@", config.query, NSNumber(value: true))
        }
    }
}

extension Contact {
    
    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Contact] {
        var contacts = [Contact]()
        
        for i in 0..<count {
            let contact = Contact(context: context)
            contact.name = "item \(i)"
            contact.email = "test_\(i)@gmail.com"
            contact.isFavorite = Bool.random()
            contact.phoneNumber = "520000000\(i)"
            contact.dob = Calendar.current.date(byAdding: .day, value: -i, to: .now) ?? .now
            contact.notes = "This is a preview for item \(i)"
            contacts.append(contact)
        }
        
        return contacts
    }
    
    static func preview(context: NSManagedObjectContext = ContactsProvider.shared.viewContext) -> Contact {
        return makePreview(count: 1, in: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = ContactsProvider.shared.viewContext) -> Contact {
        return Contact(context: context)
    }
}
