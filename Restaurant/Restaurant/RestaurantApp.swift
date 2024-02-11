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
            // This would be the canical way of doing this
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
             */
            Onboarding()
        }
    }
}
