//
//  HistoryView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
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
                }.padding()
                
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
        HistoryView().environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
    }
}
