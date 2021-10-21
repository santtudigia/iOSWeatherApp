//
//  FavoriteListScreen.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 20.10.2021.
//

import SwiftUI

struct FavoriteListView: View {
    
    @Binding var selection : Tabs
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigationArgs : NavigationArgs
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.name, ascending: false)],
        animation: .default)
    
    private var favorites: FetchedResults<Favorite>
    
    var body: some View {
        
        VStack(alignment: .leading) {

            List {
                ForEach(favorites, id: \.self) { favorite in
                    Button(action: {
                        navigationArgs.searchLocation = favorite.name!
                        selection = Tabs.weather

                    }) {
                        FavoriteRow(favorite: favorite)
                    }
                    .padding()
                }
                .onDelete(perform: { index in
                    
                    index.forEach({ i in
                        let favorite = favorites[i]
                        viewContext.delete(favorite)
                    })
                    
                    do {
                        try viewContext.save()
                    } catch {
                        print("Could not delete")
                    }
                })
                .accentColor(Color.gray)
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView(selection: .constant(.history)).environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
        .environmentObject(NavigationArgs())
    }
}
