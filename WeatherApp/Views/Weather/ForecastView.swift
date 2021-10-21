//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import SwiftUI

struct ForecastView: View {
    
    var location : String
    var lat : Double
    var lon : Double
    
    @State private var oneCallResponse : OneCallResponse? = nil
    @State private var errorMessage : String? = nil
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.name, ascending: false)],
        animation: .default)
    
    private var favorites: FetchedResults<Favorite>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("view_forecast".localize())
                .font(.title)
            
            Text(location)
                .font(.headline)
                .padding(.bottom)

            
            if oneCallResponse != nil {
                List {
                    ForEach(oneCallResponse!.hourly, id: \.self.dt) { forecast in
                        ForecastCard(forecast: forecast)
                    }
                }
                
            } else {
                Spacer()
                
                if errorMessage != nil {
                    Text(errorMessage!)
                }
            }
        }
        .padding()
        .onAppear(perform: {
            fetchWeatherByCoordinates()
        })
    }
    

    func fetchWeatherByCoordinates() {
        OneCallWeatherRequest(lat: String(lat), lon : String(lon), exclude: "daily,alerts,minutely", appid: Constants.API_KEY, units: SettingsView.getUnits())
            .dispatch(onSuccess: {(successResponse) in
                handleResponse(oneCallResponse: successResponse)
            }, onFailure: { (errorResponse, error) in
                print(location.formatToAPI())
                print("Error fetching the weather")
                print(error)
                errorMessage = "Error"
            })
    }
    
    func handleResponse(oneCallResponse : OneCallResponse) {
        self.oneCallResponse = oneCallResponse
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(location: "Vantaa", lat: 23.0, lon: 63.0)
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
