//
//  FavoritesView.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import SwiftUI

struct FavoritesView: View {
    let locations: [Location]
    @EnvironmentObject var favorites: Favorites
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(locations.filter { favorites.isFavorite(id: $0.id) }) { location in
                        NavigationLink(destination: WeatherView(locationItem: location)) {
                            
                            getFlagImage(for: location.nombre)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .cornerRadius(8)
                                .shadow(radius: 3)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favoritos")
        }
    }
    
    private func getFlagImage(for locationName: String) -> Image {
        let baseName = (locationName == "Canada") ? "CanadáCA" : locationName
        let possibleNames = [
            baseName,
            "\(baseName).png",
            "\(baseName).jpg",
            "\(baseName).jpeg",
            "banderas/\(baseName)",
            "banderas/\(baseName).png",
            "banderas/\(baseName).jpg",
            "banderas/\(baseName).jpeg"
        ]
        
        for name in possibleNames {
            if let uiImage = UIImage(named: name) {
                return Image(uiImage: uiImage)
            }
        }
        
        return Image(systemName: "exclamationmark.triangle.fill")
    }
}
