//
//  Home.swift
//  Restaurant
//
//  Created by Simo Särkkä on 8.2.2024.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            VStack {
                Menu()
            }
            .tabItem {
                Label("Menu", systemImage: "list.dash")
            }
            .environment(\.managedObjectContext, persistence.container.viewContext)
            UserProfile()
            .tabItem {
                Label("Profile", systemImage: "square.and.pencil")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
