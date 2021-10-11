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
    
    @State private var location : String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Location", text: $location)
                Spacer()
                
                Button(
                    action: {
                        fetchWeather()
                        
                    })
                {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.red)
                }
            }
        
            Divider()
            Spacer()
            
            if weatherResponse != nil {
                WeatherCard(cityWeatherResponse: weatherResponse!)
            } else {
                if errorMessage != nil {
                    Text(errorMessage!)
                }
            }
        }.onAppear() {
            //fetchWeather()
        }.padding()
    }
    
    func fetchWeather() {
        CityWeatherRequest(q: location, appid: Constants.API_KEY, units: "metric")
            .dispatch(onSuccess: {(successResponse) in
                weatherResponse = successResponse
            }, onFailure: { (errorResponse, error) in
                print(location.formatToAPI())
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
