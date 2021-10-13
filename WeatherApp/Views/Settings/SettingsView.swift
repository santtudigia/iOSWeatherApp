//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 12.10.2021.
//

import SwiftUI

struct SettingsView: View {
    
    static let unitsKey = "units"
    @AppStorage(unitsKey) var units = Units.metric.rawValue
    
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
            
            Text("links".localize())
                .font(.title)
            
            LinkButton(titleKey: "open_weather", url: "https://openweathermap.org/api")
            
            LinkButton(titleKey: "github", url: "https://github.com/santtudigia/iOSWeatherApp")
        }
    }
    
    static func getUnits() -> String {
        let defaults = UserDefaults.standard
        
        guard let result = defaults.string(forKey: unitsKey) else {
            print(Units.metric.rawValue)
            return Units.metric.rawValue
        }
        
        print(result)
        
        return result
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
