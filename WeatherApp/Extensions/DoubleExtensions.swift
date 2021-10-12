//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

extension Double {
    func formatDigits(digits : Int) -> String {
        return String(format: "%.\(digits)f", self)
    }
    
    func toTemperature() -> String {
        let defaults = UserDefaults.standard
        if let result = defaults.string(forKey: "units") {
            
            let unit = Units(rawValue: result)
            
            if(unit == nil) {
                return "\(self.formatDigits(digits: 1))"
            }
            
            var symbol = " K"
            switch(unit!) {
                case Units.metric:
                    symbol = "°C"
                case Units.standard:
                    symbol = " K"
                case Units.imperial:
                    symbol = "°F"
            }
            
            return "\(self.formatDigits(digits: 1))\(symbol)"
        } else {
            return "\(self.formatDigits(digits: 1))"
        }
    }
}
