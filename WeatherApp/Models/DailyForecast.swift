//
//  Forecast.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 21.10.2021.
//

import Foundation

struct DailyForecast : Hashable, Codable {
    var temp : Dictionary<String, Double>
    var pressure : Int
    var humidity : Int
    var dt : Int
    var weather : [Weather]
}

