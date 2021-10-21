//
//  WeatherCard.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI

struct ForecastCard: View {
    var forecast : Forecast
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(getTimeString(dt: forecast.dt))")
                Spacer()
                Text("\(forecast.temp.toTemperature())")
                Image(systemName: forecast.weather[0].icon.asWeatherIcon())
            }
        }
    }
    
    func getTimeString(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

struct ForecastCard_Previews: PreviewProvider {
    static let forecast = Forecast(temp: 1.12, pressure: 1234, humidity: 123, dt: 1634801764, weather: [])
    static var previews: some View {
        ForecastCard(forecast: forecast)
    }
}
