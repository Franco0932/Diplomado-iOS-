//
//  MainViewModel.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    @Published var locations: [Location] = []
    
    func loadLocations() {
        guard let url = Bundle.main.url(forResource: "LocationList", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        if let decoded = try? JSONDecoder().decode([Location].self, from: data) {
            self.locations = decoded
        }
    }
}
