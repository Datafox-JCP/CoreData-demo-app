//
//  ContactDetailView.swift
//  CoreDataContacts
//
//  Created by Juan Hernandez Pazos on 12/01/23.
//

import SwiftUI

struct ContactDetailView: View {
    var body: some View {
        List {
            Section("General") {
                LabeledContent {
                    Text("Email Here")
                } label: {
                    Text("Email")
                }
                
                LabeledContent {
                    Text("Phone Number Here")
                } label: {
                    Text("Phone Number")
                }
                
                LabeledContent {
                    Text(.now, style: .date)
                } label: {
                    Text("Birthday")
                }

            }
                         
            Section("Notes") {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sem mauris, bibendum in tristique sit amet, viverra nec dolor. Integer.")
            }
        }
        .navigationTitle("Name here")
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactDetailView()
        }
    }
}
