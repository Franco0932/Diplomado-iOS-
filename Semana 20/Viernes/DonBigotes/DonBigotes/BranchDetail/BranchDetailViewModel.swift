//
//  BranchDetailViewModel.swift
//  DonBigotes
//
//  Created by Franco Ruiz on 23/01/26.
//

import Foundation
import CoreLocation

class BranchDetailViewModel {
    let branch: Branch
    
    var name: String { branch.name }
    var address: String { branch.address }
    var phone: String { "Tel: \(branch.phone)" }
    
    var scheduleText: String {
        var text = "Horarios:\n"
        text += "L-V: \(branch.openingHours.weekdays.open) - \(branch.openingHours.weekdays.close)\n"
        text += "Sáb: \(branch.openingHours.saturday.open) - \(branch.openingHours.saturday.close)\n"
        
        if let sunday = branch.openingHours.sunday {
            text += "Dom: \(sunday.open) - \(sunday.close)"
        } else {
            text += "Dom: Cerrado"
        }
        return text
    }
    
    var servicesText: String {
        return "Servicios:\n• " + branch.services.joined(separator: "\n• ")
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: branch.location.latitude,
                                      longitude: branch.location.longitude)
    }
    
    init(branch: Branch) {
        self.branch = branch
    }
}
