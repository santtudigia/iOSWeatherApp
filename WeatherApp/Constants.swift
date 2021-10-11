//
//  Constants.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

struct Constants {
    static let API_BASE = "http://api.openweathermap.org"
    
    static let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
}
