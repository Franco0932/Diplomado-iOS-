//
//  ViewController.swift
//  Ejercicio3
//
//  Created by Franco Ruiz on 07/11/25.
//

import UIKit

struct Song {
    let title: String
    let artist: String
    let album: String
    let albumImageName: String
    let duration: TimeInterval
}

class ViewController: UIViewController {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!

   
    private var songs: [Song] = [
        Song(title: "Crying Lightning", artist: "Artic Monkeys", album: "Humbung(Bonus Track Version)", albumImageName: "Humbung(Bonus Track Version)", duration: 223),
        Song(title: "Buenos Días Amor", artist: "José José", album: "El Principe de la Canción",albumImageName: "El Principe de la Canción", duration: 225),
        Song(title: "Halo On Fire", artist: "Metallica", album: "Hardwired...To Self Destruct", albumImageName: "Hardwired...To Self Destruct", duration: 495)
    ]
    
    private var currentSongIndex: Int = 0
    private var isPlaying: Bool = false
    private var playbackTimer: Timer?
    private var currentTime: TimeInterval = 0
    private let playImage = UIImage(systemName: "play.fill")
    private let pauseImage = UIImage(systemName: "pause.fill")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSong(at: currentSongIndex)
        progressSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        progressSlider.value = 0.0
        currentTimeLabel.text = "0:00"
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        togglePlayPause()
    }
    
    @IBAction func forwardTapped(_ sender: UIButton) {
        nextSong()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        previousSong()
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        playbackTimer?.invalidate()
        currentTime = TimeInterval(slider.value)
        updatePlaybackTimeLabels()
        if isPlaying {
            startPlaybackTimer()
        }
    }
    
    private func loadSong(at index: Int) {
        guard index >= 0 && index < songs.count else { return }
        
        currentSongIndex = index
        let song = songs[currentSongIndex]
        playbackTimer?.invalidate()
        currentTime = 0
        songTitleLabel.text = song.title
        artistNameLabel.text = song.artist
        albumNameLabel.text = song.album
        albumImageView.image = UIImage(named: song.albumImageName)
        progressSlider.maximumValue = Float(song.duration)
        progressSlider.value = 0
        updatePlaybackTimeLabels()
        isPlaying = false
        updatePlayPauseButton()
    }
    
    private func togglePlayPause() {
        if isPlaying {
            pauseSimulation()
        } else {
            playSimulation()
        }
    }
    
    private func playSimulation() {
        guard currentTime < songs[currentSongIndex].duration else { return }
        
        isPlaying = true
        updatePlayPauseButton()
        startPlaybackTimer()
    }
    
    private func pauseSimulation() {
        isPlaying = false
        updatePlayPauseButton()
        playbackTimer?.invalidate()
    }
    
    private func nextSong() {
        var nextIndex = currentSongIndex + 1
        if nextIndex >= songs.count {
            nextIndex = 0
        }
        
        let wasPlaying = isPlaying
        loadSong(at: nextIndex)
        if wasPlaying {
            playSimulation()
        }
    }
    
    private func previousSong() {
        let wasPlaying = isPlaying
        
        if currentTime > 3 {
            currentTime = 0
            updateSliderAndLabels()
        } else {
            var prevIndex = currentSongIndex - 1
            if prevIndex < 0 {
                prevIndex = songs.count - 1
            }
            loadSong(at: prevIndex)
        }
        
        if wasPlaying {
            playSimulation()
        }
    }
    
    private func startPlaybackTimer() {
        playbackTimer?.invalidate()
        
        playbackTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlayback), userInfo: nil, repeats: true)
    }
    
    @objc private func updatePlayback() {
        let currentSong = songs[currentSongIndex]
        
        if currentTime < currentSong.duration {
            currentTime += 1
            updateSliderAndLabels()
        } else {
            nextSong()
        }
    }
    
    private func updateSliderAndLabels() {
        progressSlider.value = Float(currentTime)
        updatePlaybackTimeLabels()
    }
    
    private func updatePlaybackTimeLabels() {
        let totalDuration = songs[currentSongIndex].duration
        let remainingTime = totalDuration - currentTime
        
        currentTimeLabel.text = formatTime(currentTime)
        remainingTimeLabel.text = "-\(formatTime(remainingTime))"
    }
    
    private func updatePlayPauseButton() {
        if isPlaying {
            playPauseButton.setImage(pauseImage, for: .normal)
        } else {
            playPauseButton.setImage(playImage, for: .normal)
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let validTime = max(0, time)
        let minutes = Int(validTime) / 60
        let seconds = Int(validTime) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
