//
//  ContentView.swift
//  CoreDataContacts
//
//  Created by Juan Hernandez Pazos on 12/01/23.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            List {
                ForEach(0...10, id: \.self) { item in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: ContactDetailView()) {
                            EmptyView()
                        }
                        .opacity(0)
                        ContactRowView()
                    }
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
