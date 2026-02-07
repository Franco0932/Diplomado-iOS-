//
//  EntryEditorViewModel.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit

class EntryEditorViewModel {
    
    var entry: DiaryEntry
    
    // Callback para avisar al controlador que se guardó con éxito
    var onSaveSuccess: (() -> Void)?
    
    init(entry: DiaryEntry? = nil) {
        if let entry = entry {
            self.entry = entry
        } else {
            // Si no hay entrada, creamos una nueva vacía
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
        // Borramos la imagen anterior si existía para no llenar el disco de basura
        if let oldImageName = entry.imageFileName {
            DiaryDataService.shared.deleteImage(named: oldImageName)
        }
        
        // Guardamos la nueva
        if let newFileName = DiaryDataService.shared.saveImage(image) {
            entry.imageFileName = newFileName
        }
    }
    
    func saveEntry(asDraft: Bool) {
        entry.isDraft = asDraft
        entry.date = Date() // Actualizamos la fecha al momento de guardar
        
        var allEntries = DiaryDataService.shared.loadEntries()
        
        // Si ya existe (mismo ID), la actualizamos. Si no, la agregamos.
        if let index = allEntries.firstIndex(where: { $0.id == entry.id }) {
            allEntries[index] = entry
        } else {
            allEntries.append(entry)
        }
        
        DiaryDataService.shared.saveEntries(allEntries)
        onSaveSuccess?()
    }
    
    // Helper para cargar la imagen actual en la vista
    func currentImage() -> UIImage? {
        guard let fileName = entry.imageFileName else { return nil }
        return DiaryDataService.shared.loadImage(named: fileName)
    }
}
