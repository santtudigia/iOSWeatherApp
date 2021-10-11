//
//  CityWeatherRequest.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

struct CityWeatherRequest : Codable {
    var q : String
    var appid : String
    var units : String
}
