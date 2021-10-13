//
//  LinkButton.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 13.10.2021.
//

import SwiftUI

struct LinkButton: View {
    var titleKey : String
    var url : String
    
    var body: some View {
        Button(action: {
            openLink(link: url)
        }) {
            VStack(alignment: .leading) {
                Text(titleKey.localize())
                    .font(.headline)
                Text(url)
                    .font(.subheadline)
            }
        }
    }
    
    func openLink(link : String) {
        guard let url = URL(string: link) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}

struct LinkButton_Previews: PreviewProvider {
    static var previews: some View {
        LinkButton(titleKey: "open_weather", url: "https://openweathermap.org/api")
    }
}
