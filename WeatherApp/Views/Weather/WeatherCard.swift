//
//  WeatherCard.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI

struct WeatherCard: View {
    var cityWeatherResponse : CityWeatherResponse
    var isFavorite : Bool
    var favoriteButtonClicked : () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: cityWeatherResponse.weather[0].icon.asWeatherIcon())
                    
                Text(cityWeatherResponse.name)
                    .font(.title)
                
                Spacer()
                
                Button(action: favoriteButtonClicked) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? Color.yellow : Color.gray)
                }
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
        WeatherCard(cityWeatherResponse: cityWeatherResponse, isFavorite: true, favoriteButtonClicked: {})
    }
}
