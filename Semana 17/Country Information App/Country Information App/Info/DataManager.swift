//
//  DataManager.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    var countries: [CountryModel] = []
    var conversionRates: [String: [String: Double]] = [:]
    
    func loadData() {
        let listDTOs = loadJSON(filename: "Countrys", type: [CountryListDTO].self) ?? []
        let flagsDTO = loadJSON(filename: "Flags", type: FlagsDTO.self) ?? [:]
        let detailsDTOs = loadJSON(filename: "CountriesDetails", type: [CountryDetailDTO].self) ?? []
        let currencyDTOs = loadJSON(filename: "Currency", type: [CurrencyDTO].self) ?? []
        let poiRootDTO = loadJSON(filename: "PointsOfInterest", type: POIRootDTO.self)
        let ratesDTOs = loadJSON(filename: "CurrencyConversion", type: [ConversionRateDTO].self) ?? []
        for dict in ratesDTOs {
            if let key = dict.keys.first, let values = dict[key] {
                self.conversionRates[key] = values
            }
        }
        
        self.countries = listDTOs.map { basicDTO in
            let name = basicDTO.nombre
            let flag = flagsDTO[name] ?? "placeholder"
            let detail = detailsDTOs.first(where: { $0.nombre == name })
            let capital = detail?.capital ?? "N/A"
            let idioma = detail?.idioma ?? "N/A"
            var currencyCode = "USD"
            if let currDTO = currencyDTOs.first(where: { $0.nombre == name }) {
                currencyCode = extractCurrencyCode(from: currDTO.moneda)
            }
            
            let states = parseStates(for: name, root: poiRootDTO)

            return CountryModel(
                name: name,
                flagImageName: flag,
                capital: capital,
                language: idioma,
                currencyCode: currencyCode,
                states: states
            )
        }
    }
    
    private func extractCurrencyCode(from rawString: String) -> String {
        guard let start = rawString.firstIndex(of: "("),
              let end = rawString.firstIndex(of: ")") else { return "USD" }
        let range = rawString.index(after: start)..<end
        return String(rawString[range])
    }
    
    private func parseStates(for countryName: String, root: POIRootDTO?) -> [StateModel] {
        guard let root = root else { return [] }
        
        for countryDict in root.Paises {
            if let stateDTOs = countryDict[countryName] {
                return stateDTOs.map { StateModel(name: $0.estado, pointsOfInterest: $0.lugares) }
            }
        }
        return []
    }
    
    private func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
