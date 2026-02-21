//
//  WeatherAPI.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import Foundation

class WeatherAPIMan {
    static let shared = WeatherAPIMan()
    private init() {}
    
    func fetchWeather(for city: String) async throws -> WeaResp {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKeyClima") as? String else {
            throw APIError.invalidURL
        }
        
        let query = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let endpoint = "\(APIConfig.Weather.current.rawValue)?key=\(apiKey)&q=\(query)"
        
        return try await NetworkClient.shared.makeRequest(endpoint: endpoint, method: .get)
    }
}


