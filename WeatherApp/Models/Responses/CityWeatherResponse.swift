//
//  CityWeatherResponse.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

struct CityWeatherResponse : Hashable, Identifiable, Codable {
    var id : Int
    var name : String
    var weather : [Weather]
    var main : Main
    var coord : Coords
}
