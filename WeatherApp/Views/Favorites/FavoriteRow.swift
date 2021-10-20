//
//  FavoriteRow.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 20.10.2021.
//

import SwiftUI

struct FavoriteRow: View {
    var favorite : Favorite
    var body: some View {
        VStack {
            HStack {
                if favorite.name != nil {
                    Text(favorite.name!)
                }
                Spacer()
                Image(systemName: "star.fill")
            }
        }
    }
}

struct FavoriteRow_Previews: PreviewProvider {
    static let favorite = Favorite()
    
    static var previews: some View {
        FavoriteRow(favorite: favorite)
    }
}
