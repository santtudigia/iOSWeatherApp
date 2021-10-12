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
        
        VStack(alignment: .leading, spacing: 10) {
            Text(location)
                .font(.headline)
            
            HStack {
                Text("\(history.temperature.formatDigits(digits: 1))°C")
                    .bold()
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
