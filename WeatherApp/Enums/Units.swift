//
//  Units.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 12.10.2021.
//

import Foundation


enum Units : String, CaseIterable, Identifiable {
    case metric = "metric"
    case standard = "standard"
    case imperial = "imperial"

    var id: String { self.rawValue }
}
