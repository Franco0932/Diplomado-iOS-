//
//  PokemonLocationViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit
import MapKit

class PokemonLocationViewController: UIViewController {
    
    private let viewModel: PokemonLocationViewModel
        
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        mapView.delegate = self
        return mapView
    }()
    
    //Botón de cerrar
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        button.layer.cornerRadius = 16
        
        button.addTarget(self,
                         action: #selector(closeButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var showPokemonLocationButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Show pokemon location"
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(showPokemonLocationButtonTapped),
                         for: .touchUpInside)
        return button
    }()
        
    init(pokemon: Pokemon, pokemonImage: UIImage?) {
        self.viewModel = PokemonLocationViewModel(pokemon: pokemon, pokemonImage: pokemonImage)
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Programmatic viewcontroller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.checkLocationPermissions()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(showPokemonLocationButton)
        view.addSubview(closeButton)
    
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            showPokemonLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            showPokemonLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
        
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func showPokemonLocationButtonTapped() {
        guard let coordinate = viewModel.pokemonCoordinate else { return }
        
        mapView.removeAnnotations(mapView.annotations)
        
        let pokemonAnnotation = MKPointAnnotation()
        pokemonAnnotation.coordinate = coordinate
        pokemonAnnotation.title = viewModel.pokemonName
        
        mapView.addAnnotation(pokemonAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: coordinate,
                                           latitudinalMeters: 500,
                                           longitudinalMeters: 500)
        mapView.setRegion(mapRegion, animated: true)
    }
}

extension PokemonLocationViewController: PokemonLocationViewModelDelegate {
    
    func updateMapRegion(to coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate,
                                        latitudinalMeters: 1000,
                                        longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    //Alerta para los permisos
    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Location Permission Required",
                                      message: "To see your position and the Pokemon's on the map, enable location permissions.",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension PokemonLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "PokemonAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = viewModel.pokemonImage        
        annotationView?.frame.size = CGSize(width: 40, height: 40)
        annotationView?.contentMode = .scaleAspectFit
        
        return annotationView
    }
}
