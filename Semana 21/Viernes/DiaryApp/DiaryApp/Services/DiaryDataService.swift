//
//  DiaryDataService.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit

class DiaryDataService {
    static let shared = DiaryDataService()
    
    private let fileName = "diary_entries.json"
    
    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private init() {}
    
    
    func saveEntries(_ entries: [DiaryEntry]) {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            NSLog("Error saving entries: %@", error.localizedDescription)
        }
    }
    
    func loadEntries() -> [DiaryEntry] {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let entries = try JSONDecoder().decode([DiaryEntry].self, from: data)
            return entries.sorted(by: { $0.date > $1.date })
        } catch {
            NSLog("Error loading entries: %@", error.localizedDescription)
            return []
        }
    }
    
    
    func saveImage(_ image: UIImage) -> String? {
        let fileName = UUID().uuidString + ".jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            NSLog("Error saving image: %@", error.localizedDescription)
            return nil
        }
    }
    
    func loadImage(named fileName: String) -> UIImage? {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func deleteImage(named fileName: String) {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        try? FileManager.default.removeItem(at: fileURL)
    }
}
