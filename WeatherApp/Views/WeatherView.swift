//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI

struct WeatherView: View {
    @State private var weatherResponse : CityWeatherResponse? = nil

    @State private var errorMessage : String? = nil
    
    var body: some View {
        VStack {
            if weatherResponse != nil {
                WeatherCard(cityWeatherResponse: weatherResponse!)
            } else {
                if errorMessage != nil {
                    Text(errorMessage!)
                } else {
                    Text("Loading...")
                }
            }
        }.onAppear() {
            fetchWeather()
        }
    }
    
    func fetchWeather() {
        CityWeatherRequest(q: "Vantaa", appid: "", units: "metric")
            .dispatch(onSuccess: {(successResponse) in
                weatherResponse = successResponse
            }, onFailure: { (errorResponse, error) in
                
                print("Error fetching the weather")
                print(error)
                errorMessage = "Error"
            })
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
