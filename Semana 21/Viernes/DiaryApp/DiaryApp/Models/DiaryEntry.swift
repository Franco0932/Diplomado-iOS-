//
//  DiaryEntry.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import Foundation

struct DiaryEntry: Codable, Identifiable {
    let id: UUID
    var title: String
    var message: String
    var date: Date
    var imageFileName: String?
    var location: Location?
    var isDraft: Bool
    
    init(id: UUID = UUID(),
         title: String,
         message: String,
         date: Date = Date(),
         imageFileName: String? = nil,
         location: Location? = nil,
         isDraft: Bool = false) {
        self.id = id
        self.title = title
        self.message = message
        self.date = date
        self.imageFileName = imageFileName
        self.location = location
        self.isDraft = isDraft
    }
}
