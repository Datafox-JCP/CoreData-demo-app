    //
    //  CreateContactView.swift
    //  CoreDataContacts
    //
    //  Created by Juan Hernandez Pazos on 12/01/23.
    //

import SwiftUI

struct CreateContactView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("General") {
                TextField("Name", text: .constant(""))
                    .keyboardType(.namePhonePad)
                
                TextField("Email", text: .constant(""))
                    .keyboardType(.emailAddress)
                
                TextField("Phone Number", text: .constant(""))
                    .keyboardType(.phonePad)
                
                DatePicker("Birthday",
                           selection: .constant(.now),
                           displayedComponents: [.date])
                    .datePickerStyle(.compact)
                
                Toggle("Favorite", isOn: .constant(true))
            }
            
            Section("Notes") {
                TextField("",
                          text: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sem mauris, bibendum in tristique sit amet, viverra nec dolor. Integer."),
                          axis: .vertical)
            }
        }
        .navigationTitle("Name Here")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateContactView()
        }
    }
}
