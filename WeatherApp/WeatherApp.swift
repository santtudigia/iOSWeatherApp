//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI

@main
struct WeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
