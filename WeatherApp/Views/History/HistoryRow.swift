//
//  HistoryRow.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 12.10.2021.
//

import SwiftUI

struct HistoryRow: View {
    var history : LocationHistory
    
    var body: some View {
        let location = history.location ?? ""
        let temperature = history.temperature ?? ""
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text(location)
                        .font(.headline)
                    Text(temperature)
                        .font(.subheadline)
                }
                Spacer()
                Text("\(history.timestamp!, formatter: itemFormatter)")
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

struct HistoryRow_Previews: PreviewProvider {
    static let history = LocationHistory()
    static var previews: some View {
        HistoryRow(history: history)
    }
}
