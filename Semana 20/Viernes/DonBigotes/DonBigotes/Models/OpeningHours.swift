//
//  OpeningHours.swift
//  DonBigotes
//
//  Created by Franco Ruiz on 23/01/26.
//

import Foundation

struct OpeningHours: Codable {
    let weekdays: Schedule
    let saturday: Schedule
    let sunday: Schedule?
}

struct Schedule: Codable {
    let open: String
    let close: String
}
