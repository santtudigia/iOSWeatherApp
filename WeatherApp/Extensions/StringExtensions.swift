//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

extension String {
    func formatToAPI() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    /*
     Localizes the string
     */
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    /*Returns weather icon based on the OpenWeatheAPI defined icon strings*/
    func asWeatherIcon() -> String {
        let result = String(self.dropLast())
        let weatherIcon = WeatherIcon(rawValue: result)
        
        if(weatherIcon == nil) {
            return "questionmark"
        }
        
        switch(weatherIcon!){
            
            case WeatherIcon.broken_clouds:
                return "cloud"
            
            case WeatherIcon.cloudy:
                return "cloud"
            
            case WeatherIcon.few_clouds:
                return "cloud.sun"
            
            case WeatherIcon.clear:
                return "sun.min"
            
            case WeatherIcon.shower:
                return "cloud.sun.rain"
            
            case WeatherIcon.rain:
                return "cloud.rain"
            
            case WeatherIcon.snow:
                return "cloud.snow"
            
            case WeatherIcon.thunder:
                return "cloud.bolt.rain"
            
            case WeatherIcon.mist:
                return "cloud.fog"
        }
    }
}

