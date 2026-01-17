//
//  PokemonLocateViewController.swift
//  Pokedex2
//
//  Created by Franco Ruiz on 17/01/26.
//

import UIKit
import MapKit
import CoreLocation

class PokemonLocateViewController: UIViewController {
    
    private lazy var mapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        mapView.
        return mapView
    }()
    
    private let locationManager = CLLocationManager()
    
    private let pokemon: Pokemon
    
    private let pokemonImage: UIImage
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Programatic ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setUpView()  {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        let showPokemonLocationConfiguration = UIButton.Configuration.filled()
        showPokemonLocationConfiguration.title = "Show Pokemon Location"
        
        let showPokemonLocationButton = UIButton(configuration: showPokemonLocationConfiguration)
        showPokemonLocationButton.addTarget(self, action: #selector(showPokemonLocationButtonTapped), for: .touchUpInside)
        @objc private func showPokemonLocationButtonTapped() {
            guard let pokemonLocation = pokemon.location else { return }
            
            let pokemonCoordinate = CLLocationCoordinate2D(latitude: pokemonLocation.latitude, longitude: pokemonLocation.longitude)
            
            let pokemonAnnotation = MKPointAnnotation()
            pokemonAnnotation.coordinate = pokemonLocation
            pokemonAnnotation.title = pokemon.name
            
            mapView.addAnnotation(pokemonAnnotation)
        }
    }

}

extension PokemonLocateViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = coordinate
        
        mapView.addAnnotation(userAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        
        mapView.region = mapRegion
    }
}

extension PokemonLocateViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard (annotation is MKUserLocation) else { return nil }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.image
    }
}
