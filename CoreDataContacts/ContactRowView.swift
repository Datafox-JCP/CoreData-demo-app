//
//  ContactRowView.swift
//  CoreDataContacts
//
//  Created by Juan Hernandez Pazos on 12/01/23.
//

import SwiftUI

struct ContactRowView: View {
    
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(contact.formattedName)")
                .font(.system(size: 26, design: .rounded).bold())
            
            Text(contact.email)
                .font(.callout.bold())
            
            Text(contact.phoneNumber)
                .font(.callout.bold())
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing) {
            Button {
                toggleSave()
            } label: {
                Image(systemName: "star")
                    .font(.title3)
                    .symbolVariant(.fill)
                    .foregroundColor(contact.isFavorite ? .yellow : .gray.opacity(0.3))
            }
            .buttonStyle(.plain)
        }
    }
}

private extension ContactRowView {
    
    func toggleSave() {
        contact.isFavorite.toggle()
        do {
            if moc.hasChanges {
                try moc.save()
            }
        } catch {
            print(error)
        }
    }
}

//struct ContactRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactRowView()
//    }
//}
