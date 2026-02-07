//
//  DiaryListViewModel.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import Foundation

class DiaryListViewModel {
    
    private var entries: [DiaryEntry] = []
    
    var numberOfEntries: Int {
        return entries.count
    }
    
    func loadEntries() {
        self.entries = DiaryDataService.shared.loadEntries()
    }
    
    func entry(at index: Int) -> DiaryEntry {
        return entries[index]
    }
    
    func deleteEntry(at index: Int) {
        let entryToDelete = entries[index]
        if let imageName = entryToDelete.imageFileName {
            DiaryDataService.shared.deleteImage(named: imageName)
        }
        
        entries.remove(at: index)
        DiaryDataService.shared.saveEntries(entries)
    }
}
