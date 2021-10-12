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
        ScrollView {
            ForEach(locationHistory) { history in
                HStack {
                    Text(history.location!)
                    Spacer()
                    Text("\(history.timestamp!, formatter: itemFormatter)")
                }
                .padding()
                .onTapGesture {
                    navigationArgs.searchLocation = history.location!
                    selection = Tabs.weather
                }
                
                Divider()
            }
        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
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
