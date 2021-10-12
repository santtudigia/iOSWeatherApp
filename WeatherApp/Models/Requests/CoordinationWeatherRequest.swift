//
//  CoordinationWeatherRequest.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 12.10.2021.
//

import Foundation

struct CoordinateWeatherRequest : Codable {
    var lat : String
    var lon : String
    var appid : String
    var units : String
}
