//
//  EntryDetailViewModel.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit

class EntryDetailViewModel {
    let entry: DiaryEntry
    
    init(entry: DiaryEntry) {
        self.entry = entry
    }
    
    var dateString: String {
        entry.date.formatted(date: .long, time: .shortened)
    }
    
    func image() -> UIImage? {
        guard let name = entry.imageFileName else { return nil }
        return DiaryDataService.shared.loadImage(named: name)
    }
}
