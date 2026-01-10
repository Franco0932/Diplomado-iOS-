//
//  Domain.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import Foundation

struct CountryModel {
    let name: String
    let flagImageName: String
    let capital: String
    let language: String
    let currencyCode: String
    let states: [StateModel]
}

struct StateModel {
    let name: String
    let pointsOfInterest: [String]
}
