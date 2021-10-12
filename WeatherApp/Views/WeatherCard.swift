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
                Image(systemName: "sun.min")
                    
                Text(cityWeatherResponse.name)
                    .font(.title)
            }
            
            Divider()
            
            HStack {
                Text("Temperature: ")
                    .font(.subheadline)
                Spacer()
                Text("\(cityWeatherResponse.main.temp.formatDigits(digits: 1))°C")
            }
            
            HStack {
                Text("Pressure: ")
                    .font(.subheadline)
                Spacer()
                Text("\(cityWeatherResponse.main.pressure)")
            }
            
            HStack {
                Text("Humidity: ")
                    .font(.subheadline)
                Spacer()
                Text("\(cityWeatherResponse.main.humidity)")
            }

            Divider()
            
            ForEach(cityWeatherResponse.weather) { weather in
                    Text(weather.main)
            }
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
                icon: ""
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
