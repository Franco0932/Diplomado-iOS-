//
//  TimeManager.swift
//  StudyBudy
//
//  Created by Franco Ruiz on 07/02/26.
//

import SwiftUI

@Observable
class TimeManager {
    var totalSeconds: Int = 25 * 60
    var remainingSeconds: Int = 25 * 60
    var isRunning: Bool = false
    private var timer
    
    var progress: Double {
        guard totalSeconds > 0 else { return 0 }
        return Double(totalSeconds - remainingSeconds)/Double(totalSeconds)
    }
    var timeString: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    func start() {
        guard isRunning else { return }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in })
    }
}
