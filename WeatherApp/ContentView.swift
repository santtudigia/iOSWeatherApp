//
//  ContentView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var navigationArgs = NavigationArgs()

    @State private var selection: Tabs = .weather

    var body: some View {
        TabView(selection: $selection) {
            WeatherView()
                .tag(Tabs.weather)
                .tabItem {
                    Label("weather".localize(), systemImage: "sun.min")
                }

            FavoriteListView(selection: $selection)
                .tag(Tabs.favorites)
                .tabItem {
                    Label("favorites".localize(), systemImage: "star.fill")
                }
            
            HistoryView(selection: $selection)
                .tag(Tabs.history)
                .tabItem {
                    Label("history".localize(), systemImage: "clock")
                }
            
            SettingsView()
                .tag(Tabs.settings)
                .tabItem {
                    Label("settings".localize(), systemImage: "gear")
                }
                    
        }
        .accentColor(.red)
        .environmentObject(navigationArgs)
        .animation(.easeInOut)
        .transition(.slide)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
