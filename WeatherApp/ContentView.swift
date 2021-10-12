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

    @StateObject var modelData = ModelData()

    @State private var selection: Tabs = .weather

    var body: some View {
        TabView(selection: $selection) {
            WeatherView()
                .tag(Tabs.weather)
                .tabItem {
                    Label("Weather", systemImage: "sun.min")
                }
                .toolbar {
                    /*ToolbarItem {
                        Button(action: {
                            showingHistory.toggle()
                        }) {
                            Label("History", systemImage: "clock")
                        }
                    }*/
                }
            HistoryView(selection: $selection)
                .tag(Tabs.history)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                
        }
        .accentColor(.red)
        .environmentObject(modelData)
        .animation(.easeInOut)
        .transition(.slide)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
