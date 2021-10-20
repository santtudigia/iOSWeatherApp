//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct WeatherView: View {
    
    @AppStorage("lastLocationSearch") var lastLocationSearch = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigationArgs : NavigationArgs
    
    @StateObject var locationManager = LocationModel()
    @State private var weatherResponse : CityWeatherResponse? = nil
    @State private var errorMessage : String? = nil
    @State private var mapRegion = MKCoordinateRegion()
    
    var search : String = ""
    
    @State private var location : String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.name, ascending: false)],
        animation: .default)
    
    private var favorites: FetchedResults<Favorite>
    
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
            
            
            if weatherResponse != nil {
                MapView(region: $mapRegion)
                
                WeatherCard(cityWeatherResponse: weatherResponse!,
                            isFavorite: isLocationFavorite(location: weatherResponse!.name), favoriteButtonClicked: {
                    favoriteLocation(location: weatherResponse!.name)
                }
                )
                
                LocationCard(latitude: weatherResponse!.coord.lat, longitude: weatherResponse!.coord.lon)
                    .padding(.top)
                
            } else {
                Spacer()
                
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
        
        updateRegion(latitude: cityWeatherResponse.coord.lat, longitude: cityWeatherResponse.coord.lon)
    }
    
    func addToHistory(weatherResponse : CityWeatherResponse) {
        let locationHistory = LocationHistory(context: viewContext)
        locationHistory.location = weatherResponse.name
        locationHistory.temperature = weatherResponse.main.temp.toTemperature()
        locationHistory.timestamp = Date()
        
        do {
            try viewContext.save()
        }  catch {
            print("Error saving location history")
        }
    }
    
    private func favoriteLocation(location : String) {
        
        if !isLocationFavorite(location: location) {
            //Add favorite
            let favorite = Favorite(context: viewContext)
            favorite.name = location
        } else {
            //Remove favorite
            guard let favorite = favorites.first(where: { favorite in
                favorite.name == location
            }) else {
                return
            }
            
            viewContext.delete(favorite)
        }
        
        do {
            try viewContext.save()
        }  catch {
            print("Error updating favorites")
        }
    }

    private func isLocationFavorite(location : String) -> Bool {
        return favorites.contains(where: {
            $0.name == weatherResponse!.name
        })
    }

    private func updateRegion(latitude: Double, longitude: Double) {
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
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
