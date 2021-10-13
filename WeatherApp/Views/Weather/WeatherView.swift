//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI
import CoreData
import CoreLocation

struct WeatherView: View {
    
    @AppStorage("lastLocationSearch") var lastLocationSearch = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigationArgs : NavigationArgs
    
    @StateObject var locationManager = LocationModel()
    @State private var weatherResponse : CityWeatherResponse? = nil
    @State private var errorMessage : String? = nil

    var search : String = ""
    
    @State private var location : String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("current_weather".localize())
                .font(.title)
                .padding(.bottom)

            
            HStack {
                TextField("location".localize(), text: $location)
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
                
                Button(action: {
                    fetchWeatherByCoordinates()
                }) {
                    Image(systemName: "location.circle.fill")
                        .foregroundColor(Color.red)
                }
                
            }
        
            Divider()
            
            Spacer()
            
            if weatherResponse != nil {
                WeatherCard(cityWeatherResponse: weatherResponse!)
                    
                LocationCard(latitude: weatherResponse!.coord.lat, longitude: weatherResponse!.coord.lon)
                    .padding(.top)
                
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
            } else if lastLocationSearch != "" {
                fetchWeather(location: lastLocationSearch)
            }
        })
    }
    
    func fetchWeather(location : String) {
        CityWeatherRequest(q: location, appid: Constants.API_KEY, units: SettingsView.getUnits())
            .dispatch(onSuccess: {(successResponse) in
                handleResponse(cityWeatherResponse: successResponse)
            }, onFailure: { (errorResponse, error) in
                print(location.formatToAPI())
                print("Error fetching the weather")
                print(error)
                errorMessage = "Error"
            }) 
    }
    
    func fetchWeatherByCoordinates() {
        locationManager.askPermission()
        
        let lat = locationManager.lastLocation?.coordinate.latitude ?? nil
        let lon = locationManager.lastLocation?.coordinate.longitude ?? nil
        
        if(lat != nil && lon != nil) {
            CoordinateWeatherRequest(lat: String(lat!), lon : String(lon!), appid: Constants.API_KEY, units: SettingsView.getUnits())
                .dispatch(onSuccess: {(successResponse) in
                    handleResponse(cityWeatherResponse: successResponse)
                }, onFailure: { (errorResponse, error) in
                    print(location.formatToAPI())
                    print("Error fetching the weather")
                    print(error)
                    errorMessage = "Error"
                })
        }
    }
    
    func handleResponse(cityWeatherResponse : CityWeatherResponse) {
        weatherResponse = cityWeatherResponse
        lastLocationSearch = cityWeatherResponse.name
        addToHistory(weatherResponse: cityWeatherResponse)
    }
    
    func addToHistory(weatherResponse : CityWeatherResponse) {
        let locationHistory = LocationHistory(context: viewContext)
        locationHistory.location = weatherResponse.name
        locationHistory.temperature = weatherResponse.main.temp
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
