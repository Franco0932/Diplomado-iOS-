//
//  WeatherViewModel.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import Foundation
import Combine
import MapKit
import SwiftUI

enum TemperatureUnit {
    case celsius, fahrenheit
}

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: WeaResp?
    @Published var isLoading = true
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    @Published var tempUnit: TemperatureUnit = .celsius
    @Published var position: MapCameraPosition = .automatic
    
    func fetchWeather(city: String) async {
        isLoading = true
        do {
            let data = try await WeatherAPIMan.shared.fetchWeather(for: city)
            self.weather = data
            
            let coordinate = CLLocationCoordinate2D(latitude: data.location.lat, longitude: data.location.lon)
            let region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
            )
            self.position = .region(region)
            
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.showErrorAlert = true
            self.isLoading = false
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = inputFormatter.date(from: dateString) else { return dateString }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return outputFormatter.string(from: date)
    }
}
