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
        
        NavigationView {
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
            .navigationBarTitle(getNavigationTitle(), displayMode: NavigationBarItem.TitleDisplayMode.inline)
            .accentColor(.red)
            .environmentObject(navigationArgs)
            .animation(.easeInOut)
            .transition(.slide)
            .onAppear {
                UITabBar.appearance().isTranslucent = false
                UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
            }
        }
    }
    
    private func getNavigationTitle() -> String {
        switch(selection) {
            case Tabs.weather:
                return "weather".localize()
            case Tabs.favorites:
                return "favorites".localize()
            case Tabs.history:
                return "history".localize()
            case Tabs.settings:
                return "settings".localize()
            default:
                return ""
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
