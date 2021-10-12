//
//  WeatherCard.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI

struct WeatherCard: View {
    var cityWeatherResponse : CityWeatherResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: getWeatherIcon(icon: cityWeatherResponse.weather[0].icon))
                    
                Text(cityWeatherResponse.name)
                    .font(.title)
            }
            
            Divider()
            
            HStack {
                Text("\("temperature".localize()): ")
                    .font(.subheadline)
                Spacer()
                Text("\(cityWeatherResponse.main.temp.toTemperature())")
            }
            
            HStack {
                Text("\("pressure".localize()): ")
                    .font(.subheadline)
                Spacer()
                Text("\(cityWeatherResponse.main.pressure)")
            }
            
            HStack {
                Text("\("humidity".localize()): ")
                    .font(.subheadline)
                Spacer()
                Text("\(cityWeatherResponse.main.humidity)")
            }

            Divider()
        }
    }
    
    func getWeatherIcon(icon : String) -> String {
        let result = String(icon.dropLast())
        let weatherIcon = WeatherIcon(rawValue: result)
        
        if(weatherIcon == nil) {
            return "questionmark"
        }
        
        print(weatherIcon!)
        
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

struct WeatherCard_Previews: PreviewProvider {
    static let cityWeatherResponse = CityWeatherResponse(
        id: 1,
        name : "Vantaa",
        weather: [
            Weather(
                id: 1,
                main: "Cloudy",
                description: "",
                icon: "01d"
            )
        ],
        main : Main(
            temp: 12.3,
            pressure: 1220,
            humidity: 120
        ),
        coord: Coords(
            lat: 23.1234,
            lon: 64.1234
        )
    )
    static var previews: some View {
        WeatherCard(cityWeatherResponse: cityWeatherResponse)
    }
}
