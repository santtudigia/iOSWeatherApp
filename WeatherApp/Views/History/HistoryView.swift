//
//  HistoryView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    
    @Binding var selection : Tabs
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigationArgs : NavigationArgs
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \LocationHistory.timestamp, ascending: false)],
        animation: .default)
    
    private var locationHistory: FetchedResults<LocationHistory>
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("history".localize())
                .padding()
                .font(.title)
            
            List {
                ForEach(locationHistory, id: \.timestamp) { history in
                    Button(action: {
                        navigationArgs.searchLocation = history.location!
                        selection = Tabs.weather

                    }) {
                        HistoryRow(history: history)
                    }
                    .padding()
                }
                .accentColor(Color.gray)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(selection: .constant(.history)).environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
        .environmentObject(NavigationArgs())
    }
}
