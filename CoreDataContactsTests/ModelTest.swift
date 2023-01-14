//
//  ModelTest.swift
//  CoreDataContactsTests
//
//  Created by Juan Hernandez Pazos on 13/01/23.
//

import XCTest
@testable import CoreDataContacts

final class ModelTest: XCTestCase {
    
    private var provider: ContactsProvider!
    
    override func setUp() {
        provider = .shared
    }
    
    override func tearDown() {
        provider = nil
    }

    func testContactIsEmpty() {
        
        let contact = Contact.empty(context: provider.viewContext)
        XCTAssertEqual(contact.name, "")
        XCTAssertEqual(contact.phoneNumber, "")
        XCTAssertEqual(contact.email, "")
        XCTAssertEqual(contact.notes, "")
        XCTAssertFalse(contact.isFavorite)
        XCTAssertTrue(Calendar.current.isDateInToday(contact.dob))
    }
    
    func testContactIsNotValid() {
        let contact = Contact.empty(context: provider.viewContext)
        XCTAssertFalse(contact.isValid)
    }
    
    func testContactIsValid() {
        let contact = Contact.preview(context: provider.viewContext)
        XCTAssertTrue(contact.isValid)
    }
    
    func testContactsBirthdayIsValid() {
        let contact = Contact.preview(context: provider.viewContext)
        XCTAssertTrue(contact.isBirthday)
    }
    
    func testContactsBirthdayIsNotValid() throws {
        let contact = try XCTUnwrap(Contact.makePreview(count: 2, in: provider.viewContext).last)
        XCTAssertFalse(contact.isBirthday)
    }
    
    func testMakeContactsPreviewIsValid() {
        let count = 5
        let contacts = Contact.makePreview(count: count, in: provider.viewContext)
        
        for i in 0..<contacts.count {
            let item = contacts[i]
            XCTAssertEqual(item.name, "item \(i)")
            XCTAssertEqual(item.email, "test_\(i)@gmail.com")
            XCTAssertNotNil(item.isFavorite)
            XCTAssertEqual(item.phoneNumber, "520000000\(i)")
            
            let dateToCompare = Calendar.current.date(byAdding: .day, value: -i, to: .now)
            let dobDay = Calendar.current.dateComponents([.day], from: item.dob, to: dateToCompare!).day
            
            XCTAssertEqual(dobDay, 0)
            XCTAssertEqual(item.notes, "This is a preview for item \(i)")
        }
    }
    
    func testFilterFavContactsRequestIsValid() {
        let request = Contact.filter(width: .init(filter: .fav))
        XCTAssertEqual("isFavorite == 1", request.predicateFormat)
    }
    
    func testFilterAllFavContactsRequestIsValid() {
        let request = Contact.filter(width: .init(filter: .all))
        XCTAssertEqual("TRUEPREDICATE", request.predicateFormat)
    }
    
    func testFilterAllWithQueryContactsRequestIsValid() {
        let query = "juan"
        let request = Contact.filter(width: .init(query: query))
        XCTAssertEqual("name CONTAINS[cd] \"\(query)\"", request.predicateFormat)
    }
    
    func testFilterFavWithQueryContactsRequestIsValid() {
        let query = "juan"
        let request = Contact.filter(width: .init(query: query, filter: .fav))
        XCTAssertEqual("name CONTAINS[cd] \"\(query)\" AND isFavorite == 1", request.predicateFormat)
    }
}
