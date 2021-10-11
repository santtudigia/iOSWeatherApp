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

    @State private var showingHistory = false

    var body: some View {
        NavigationView {
            WeatherView()
                .navigationTitle("Weather")
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showingHistory.toggle()
                        }) {
                            Label("History", systemImage: "clock")
                        }
                    }
                }
                .sheet(isPresented: $showingHistory) {
                    HistoryView()
                        .environment(\.managedObjectContext, self.viewContext)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
