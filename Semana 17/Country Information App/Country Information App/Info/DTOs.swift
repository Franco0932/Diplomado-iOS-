//
//  DTOs.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import Foundation

struct CountryListDTO: Decodable {
    let id: Int
    let nombre: String
}

typealias FlagsDTO = [String: String]

struct CountryDetailDTO: Decodable {
    let nombre: String
    let capital: String
    let idioma: String
}

struct CurrencyDTO: Decodable {
    let nombre: String
    let moneda: String
}

typealias ConversionRateDTO = [String: [String: Double]]

struct POIRootDTO: Decodable {
    let Paises: [[String: [StateDTO]]]
}

struct StateDTO: Decodable {
    let estado: String
    let lugares: [String]
}


struct CapitalRootDTO: Decodable {
}
