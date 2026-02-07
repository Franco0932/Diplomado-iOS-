//
//  EntryEditorViewModel.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit

class EntryEditorViewModel {
    
    var entry: DiaryEntry
    
    init(entry: DiaryEntry? = nil) {
        if let entry = entry {
            self.entry = entry
        } else {
            self.entry = DiaryEntry(title: "", message: "", isDraft: true)
        }
    }
    
    func updateTitle(_ text: String) {
        entry.title = text
    }
    
    func updateMessage(_ text: String) {
        entry.message = text
    }
    
    func updateLocation(_ location: Location) {
        entry.location = location
    }
    
    func saveImage(_ image: UIImage) {
        if let oldName = entry.imageFileName {
            DiaryDataService.shared.deleteImage(named: oldName)
        }
        if let newName = DiaryDataService.shared.saveImage(image) {
            entry.imageFileName = newName
        }
    }
    
    func saveEntry(asDraft: Bool) {
        entry.isDraft = asDraft
        entry.date = Date()
        
        var allEntries = DiaryDataService.shared.loadEntries()
        
        if let index = allEntries.firstIndex(where: { $0.id == entry.id }) {
            allEntries[index] = entry
        } else {
            allEntries.append(entry)
        }
        
        DiaryDataService.shared.saveEntries(allEntries)
    }
    
    func currentImage() -> UIImage? {
        guard let name = entry.imageFileName else { return nil }
        return DiaryDataService.shared.loadImage(named: name)
    }
}
