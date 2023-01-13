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
    
    @State private var hasError: Bool = false
    
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
        .navigationTitle(vm.isNew ? "Add new contact" : "Update contact")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    validate()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .alert("Something is wrong", isPresented: $hasError, actions: {}) {
            Text("👀 It's looks like your form is invalid 👀")
        }
    }
}

private extension CreateContactView {
    
    func validate() {
        if vm.contact.isValid {
            do {
                try vm.save()
                dismiss()
            } catch {
                print(error)
            }
        } else {
            hasError = true
        }
    }
}

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let preview = ContactsProvider.shared
            CreateContactView(vm: .init(provider: preview))
                .environment(\.managedObjectContext, preview.viewContext)
        }
    }
}
