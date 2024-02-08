//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by Simo Särkkä on 5.2.2024.
//

import SwiftUI

@main
struct RestaurantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            /*
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
             */
            Onboarding()
        }
    }
}
