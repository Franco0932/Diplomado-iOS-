//
//  ContentView.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import SwiftUI

struct MainView: View {
    @StateObject private var favorites = Favorites()
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        TabView {
            LocationsView(locations: viewModel.locations).tabItem {
                Label("Ubicación", systemImage: "mappin.and.ellipse")
            }
            
            FavoritesView(locations: viewModel.locations).tabItem {
                Label("Favoritos", systemImage: "star.fill")
            }
        }
        .environmentObject(favorites)
        .onAppear {
            viewModel.loadLocations()
        }
    }
}

#Preview {
    MainView()
}
