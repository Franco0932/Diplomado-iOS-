//
//  EntryDetailViewController.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit
import MapKit
//import Lottie
import CoreLocation

class EntryDetailViewController: UIViewController {
    
    private let viewModel: EntryDetailViewModel
    private let locationManager = CLLocationManager()
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let bodyLabel = UILabel()
    private let mapView = MKMapView()
    private let segmentedControl = UISegmentedControl(items: ["Automovil", "Caminando"])
    private let directionsButton = UIButton(type: .system)
    //private let lottieView = LottieAnimationView(name: "jumping_pokeball")
    
    init(entry: DiaryEntry) {
        self.viewModel = EntryDetailViewModel(entry: entry)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        displayData()
        
        locationManager.requestWhenInUseAuthorization()
        
        if viewModel.entry.location != nil {
            calculateRoute()
        }
    }
    
    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.backgroundColor = .secondarySystemBackground
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 15)
        
        bodyLabel.numberOfLines = 0
        
        mapView.layer.cornerRadius = 10
        mapView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(calculateRoute), for: .valueChanged)
        
        directionsButton.setTitle("Ver Ruta", for: .normal)
        directionsButton.addTarget(self, action: #selector(calculateRoute), for: .touchUpInside)
        
//        lottieView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        lottieView.contentMode = .scaleAspectFit
//        lottieView.loopMode = .loop
//        lottieView.play()
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(bodyLabel)
        //stackView.addArrangedSubview(lottieView)
        
        if viewModel.entry.location != nil {
            stackView.addArrangedSubview(mapView)
            stackView.addArrangedSubview(segmentedControl)
            stackView.addArrangedSubview(directionsButton)
        }
    }
    
    private func displayData() {
        titleLabel.text = viewModel.entry.title
        dateLabel.text = viewModel.dateString
        bodyLabel.text = viewModel.entry.message
        
        if let img = viewModel.image() {
            imageView.image = img
        } else {
            imageView.isHidden = true
        }
        
        if let loc = viewModel.entry.location {
            let coord = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: false)
        }
    }
    
    @objc private func calculateRoute() {
        guard let loc = viewModel.entry.location else { return }
        
        mapView.removeOverlays(mapView.overlays)
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)))
        
        if segmentedControl.selectedSegmentIndex == 0 {
            request.transportType = .automobile
        } else {
            request.transportType = .walking
        }
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self, let route = response?.routes.first else { return }
            
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
        }
    }
}

extension EntryDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        if segmentedControl.selectedSegmentIndex == 0 {
            renderer.strokeColor = .systemBlue
        } else {
            renderer.strokeColor = .systemGreen
        }
        renderer.lineWidth = 5
        return renderer
    }
}
