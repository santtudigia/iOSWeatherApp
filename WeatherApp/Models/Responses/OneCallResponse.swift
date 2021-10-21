//
//  CityWeatherResponse.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

struct OneCallResponse : Hashable, Codable {
    var current : Forecast
    var hourly : [Forecast]
}
