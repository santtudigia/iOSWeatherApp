//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 12.10.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("units") var units = Units.metric.rawValue
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("units".localize())
                    .font(.headline)
                Picker("units".localize(), selection: $units) {
                    ForEach(Units.allCases) { unit in
                        Text(unit.rawValue.localize()).tag(unit)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
