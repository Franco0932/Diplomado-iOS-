//
//  WeaResp.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import Foundation

struct WeaResp: Codable {
    let location: WeatherLocation
    let current: CurrentWeather
}

struct WeatherLocation: Codable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: WeatherCondition
    let uv: Double
    let last_updated: String
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}
