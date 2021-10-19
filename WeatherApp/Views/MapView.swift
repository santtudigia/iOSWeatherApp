//
//  MapView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 19.10.2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var region : MKCoordinateRegion

    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(region: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.1234, longitude: 63.1233), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))))
    }
}
