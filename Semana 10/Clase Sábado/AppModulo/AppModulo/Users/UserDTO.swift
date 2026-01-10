//
//  UserDTO.swift
//  AppModulo
//
//  Created by Franco Ruiz on 05/12/25.
//

import Foundation

struct UserDTO: Decodable{
    let id: Int
    let name: String
    let userName: String
    let email: String
    let address: AddressDTO
    
    struct AddressDTO: Decodable {
        let street: String
        let city: String
        let latitude: String?
        let longitude: String?
        
        private enum CodingKeys: String, CodingKey {
            case street
            case city
            case geolocalization = "geo"
        }
        
        private enum GeoCodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lng"
        }
        
        init(from decoder: any Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.street = try values.decode(String.self, forKey: .street)
            self.city = try values.decode(String.self, forKey: .city)
            let geo = try values.nestedContainer(keyedBy: GeoCodingKeys.self, forKey: .geolocalization)
            self.latitude = try geo.decode(String.self, forKey: .latitude)
            self.longitude = try geo.decode(String.self, forKey: .longitude)
        }
    }
}


