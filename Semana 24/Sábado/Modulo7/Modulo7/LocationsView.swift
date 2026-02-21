//
//  LocationView.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import SwiftUI

struct LocationsView: View {
    let locations: [Location]
    
    var body: some View {
        NavigationView {
            List(locations) { location in
                NavigationLink(destination: WeatherView(locationItem: location)) {
                    HStack {
                        Text(location.nombre)
                            .font(.headline)
                        
                        Spacer()
                        
                        getFlagImage(for: location.nombre)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 30)
                            .cornerRadius(4)
                            .shadow(radius: 2)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Ubicaciones")
        }
    }
    
    private func getFlagImage(for locationName: String) -> Image {
        let baseName = (locationName == "Canada") ? "CanadáCA" : locationName
        
        let extensions = ["", ".png", ".jpg", ".jpeg"]
        
        for ext in extensions {
            if let uiImage = UIImage(named: "\(baseName)\(ext)") {
                return Image(uiImage: uiImage)
            }
            if let uiImage = UIImage(named: "banderas/\(baseName)\(ext)") {
                return Image(uiImage: uiImage)
            }
        }
        
        return Image(systemName: "exclamationmark.triangle.fill")
    }
}
