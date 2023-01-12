//
//  Contact.swift
//  CoreDataContacts
//
//  Created by Juan Hernandez Pazos on 12/01/23.
//

import Foundation
import CoreData

final class Contact: NSManagedObject {
    
    @NSManaged var dob: Date
    @NSManaged var name: String
    @NSManaged var notes: String
    @NSManaged var phoneNumber: String
    @NSManaged var email: String
    @NSManaged var isFavorite: Bool
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setValue(Date.now, forKey: "dob")
        setValue(false, forKey: "isFavorite")
    }
}
