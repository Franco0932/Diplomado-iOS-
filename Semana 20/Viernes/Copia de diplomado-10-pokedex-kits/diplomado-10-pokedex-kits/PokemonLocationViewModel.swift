//
//  PokemonLocationViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Franco Ruiz on 23/01/26.
//

import Foundation
import CoreLocation
import UIKit

protocol PokemonLocationViewModelDelegate: AnyObject {
    func showPermissionDeniedAlert()
    func updateMapRegion(to coordinate: CLLocationCoordinate2D)
}

class PokemonLocationViewModel: NSObject {
    
    let pokemon: Pokemon
    let pokemonImage: UIImage?
    private let locationManager = CLLocationManager()
    
    weak var delegate: PokemonLocationViewModelDelegate?
    
    var pokemonName: String { pokemon.name }
    
    var pokemonCoordinate: CLLocationCoordinate2D? {
        guard let location = pokemon.location else { return nil }
        return CLLocationCoordinate2D(latitude: location.latitude,
                                      longitude: location.longitude)
    }
    
    init(pokemon: Pokemon, pokemonImage: UIImage?) {
        self.pokemon = pokemon
        self.pokemonImage = pokemonImage
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
        
    func checkLocationPermissions() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            delegate?.showPermissionDeniedAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

extension PokemonLocationViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermissions()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.updateMapRegion(to: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
}
