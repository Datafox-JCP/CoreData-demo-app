    //
    //  CreateContactView.swift
    //  CoreDataContacts
    //
    //  Created by Juan Hernandez Pazos on 12/01/23.
    //

import SwiftUI

struct CreateContactView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: EditContactViewModel
    
    var body: some View {
        List {
            Section("General") {
                TextField("Name", text: $vm.contact.name)
                    .keyboardType(.namePhonePad)
                
                TextField("Email", text: $vm.contact.email)
                    .keyboardType(.emailAddress)
                
                TextField("Phone Number", text: $vm.contact.phoneNumber)
                    .keyboardType(.phonePad)
                
                DatePicker("Birthday",
                           selection: $vm.contact.dob,
                           displayedComponents: [.date])
                    .datePickerStyle(.compact)
                
                Toggle("Favorite", isOn: $vm.contact.isFavorite)
            }
            
            Section("Notes") {
                TextField("",
                          text: $vm.contact.notes,
                          axis: .vertical)
            }
        }
        .navigationTitle("Name Here")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    do {
                        try vm.save()
                        dismiss()
                    } catch {
                        print(error)
                    }
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
            CreateContactView(vm: .init(provider: .shared))
        }
    }
}
