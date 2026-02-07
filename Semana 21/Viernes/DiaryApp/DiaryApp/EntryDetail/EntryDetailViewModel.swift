//
//  EntryDetailViewModel.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import Foundation
import UIKit

class EntryDetailViewModel {
    
    let entry: DiaryEntry
    
    init(entry: DiaryEntry) {
        self.entry = entry
    }
    
    var dateText: String {
        return entry.date.formatted(date: .long, time: .shortened)
    }
    
    var locationCoordinate: (Double, Double)? {
        guard let loc = entry.location else { return nil }
        return (loc.latitude, loc.longitude)
    }
    
    func getImage() -> UIImage? {
        guard let fileName = entry.imageFileName else { return nil }
        return DiaryDataService.shared.loadImage(named: fileName)
    }
}
