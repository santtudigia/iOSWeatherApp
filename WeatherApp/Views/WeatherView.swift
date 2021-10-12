//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI
import CoreData

struct WeatherView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigationArgs : NavigationArgs
    
    @State private var weatherResponse : CityWeatherResponse? = nil
    @State private var errorMessage : String? = nil
    
    var search : String = ""
    
    @State private var location : String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Location", text: $location)
                Spacer()
                
                Button(
                    action: {
                        self.endTextEditing()
                        fetchWeather(location: location)
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
        }
        .padding()
        .onTapGesture {
            self.endTextEditing()
        }
        .onAppear(perform: {
            if navigationArgs.searchLocation != "" {
                location = navigationArgs.searchLocation
                fetchWeather(location: location)
                navigationArgs.searchLocation = ""
            }
        })
    }
    
    func fetchWeather(location : String) {
        CityWeatherRequest(q: location, appid: Constants.API_KEY, units: "metric")
            .dispatch(onSuccess: {(successResponse) in
                weatherResponse = successResponse
                
                addToHistory(location: location)
            }, onFailure: { (errorResponse, error) in
                print(location.formatToAPI())
                print("Error fetching the weather")
                print(error)
                errorMessage = "Error"
            }) 
    }
    
    func addToHistory(location : String) {
        let locationHistory = LocationHistory(context: viewContext)
        locationHistory.location = location
        locationHistory.timestamp = Date()
        
        do {
            try viewContext.save()
        }  catch {
            print("Error saving location history")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
            .environmentObject(NavigationArgs())
    }
}
