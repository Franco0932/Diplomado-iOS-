//
//  LocationSearchViewModel.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import Foundation
import MapKit

protocol LocationSearchViewModelDelegate: AnyObject {
    func didUpdateResults()
}

class LocationSearchViewModel: NSObject, MKLocalSearchCompleterDelegate {
    
    private var completer: MKLocalSearchCompleter
    var searchResults: [MKLocalSearchCompletion] = []
    
    weak var delegate: LocationSearchViewModelDelegate?
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
        completer.resultTypes = .pointOfInterest
    }
    
    func search(query: String) {
        completer.queryFragment = query
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        delegate?.didUpdateResults()
    }
    
    func getCoordinate(for completion: MKLocalSearchCompletion, completionHandler: @escaping (Location?) -> Void) {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            guard let item = response?.mapItems.first,
                  let coordinate = item.placemark.location?.coordinate else {
                completionHandler(nil)
                return
            }
            
            let location = Location(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude,
                addressString: "\(completion.title), \(completion.subtitle)"
            )
            completionHandler(location)
        }
    }
}
