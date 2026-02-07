//
//  EntryDetailViewController.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit
import MapKit
import CoreLocation

class EntryDetailViewController: UIViewController {
    
    private let viewModel: EntryDetailViewModel
    private let locationManager = CLLocationManager()
    
    // MARK: - UI Elements
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIStackView()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .secondaryLabel
        return l
    }()
    
    private lazy var messageLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        mv.layer.cornerRadius = 12
        mv.delegate = self
        mv.showsUserLocation = true
        return mv
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Automóvil", "Caminando"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(didChangeTransportType), for: .valueChanged)
        return sc
    }()
    
    private lazy var directionsButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Ver Ruta"
        config.image = UIImage(systemName: "arrow.triangle.turn.up.right.diamond.fill")
        config.imagePadding = 8
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(calculateRoute), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Init
    init(entry: DiaryEntry) {
        self.viewModel = EntryDetailViewModel(entry: entry)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detalle"
        
        setupLayout()
        configureData()
        
        // Permisos de ubicación para trazar ruta desde mi posición
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.axis = .vertical
        contentView.spacing = 16
        contentView.isLayoutMarginsRelativeArrangement = true
        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 30, right: 16)
        
        contentView.addArrangedSubview(imageView)
        contentView.addArrangedSubview(titleLabel)
        contentView.addArrangedSubview(dateLabel)
        contentView.addArrangedSubview(messageLabel)
        
        // Elementos de mapa solo si existe ubicación
        if viewModel.entry.location != nil {
            contentView.addArrangedSubview(mapView)
            contentView.addArrangedSubview(segmentedControl)
            contentView.addArrangedSubview(directionsButton)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureData() {
        titleLabel.text = viewModel.entry.title
        messageLabel.text = viewModel.entry.message
        dateLabel.text = viewModel.dateText
        imageView.image = viewModel.getImage()
        imageView.isHidden = (imageView.image == nil)
        
        if let coordinate = viewModel.locationCoordinate {
            let coord = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            annotation.title = viewModel.entry.title
            mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: false)
        }
    }
    
    // MARK: - Map Logic
    @objc private func didChangeTransportType() {
        calculateRoute()
    }
    
    @objc private func calculateRoute() {
        guard let targetCoord = viewModel.locationCoordinate else { return }
        
        // Limpiamos rutas previas
        mapView.removeOverlays(mapView.overlays)
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: targetCoord.0, longitude: targetCoord.1)))
        
        request.transportType = segmentedControl.selectedSegmentIndex == 0 ? .automobile : .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self, let route = response?.routes.first else {
                // REGLA NO PRINT: Ignoramos el error silenciosamente
                return
            }
            
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
        }
    }
}

extension EntryDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = segmentedControl.selectedSegmentIndex == 0 ? .systemBlue : .systemGreen
        renderer.lineWidth = 5
        return renderer
    }
}
