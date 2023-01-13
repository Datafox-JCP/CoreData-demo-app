//
//  NoContactView.swift
//  CoreDataContacts
//
//  Created by Juan Hernandez Pazos on 12/01/23.
//

import SwiftUI

struct NoContactView: View {
    var body: some View {
        VStack {
            Text("👀 No contacts")
                .font(.largeTitle.bold())
            
            Text("It's seems it's empty here. Create some contacts 🖕🏻")
                .font(.callout)
        }
    }
}

struct NoContactView_Previews: PreviewProvider {
    static var previews: some View {
        NoContactView()
    }
}
