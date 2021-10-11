//
//  Weather.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

struct Weather : Hashable, Codable, Identifiable {
    var id : Int
    var main : String
    var description : String
    var icon : String
}
