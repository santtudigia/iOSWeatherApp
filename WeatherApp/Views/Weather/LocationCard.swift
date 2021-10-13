//
//  LocationCard.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 13.10.2021.
//

import SwiftUI

struct LocationCard: View {
    var latitude : Double?
    var longitude : Double?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("location".localize())
                    .font(.headline)
                Text("\("latitude".localize()): \(latitude ?? 0)")
                    .font(.caption)
                Text("\("longitude".localize()): \(longitude ?? 0)")
                    .font(.caption)
            }
            Spacer()
        }
    }
}

struct LocationCard_Previews: PreviewProvider {
    static var previews: some View {
        LocationCard(latitude: 23.3314, longitude: 63.52324)
    }
}
