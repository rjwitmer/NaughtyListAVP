//
//  playSound.swift
//  NaughtyListAVP
//
//  Created by Bob Witmer on 2025-09-19.
//
import SwiftUI
import AVFAudio

private var audioPlayer: AVAudioPlayer!

func playSound(soundName: String) {
    guard let soundFile = NSDataAsset(name: soundName) else {
        print("😡 ERROR: Could not read sound file named \(soundName)")
        return
    }
    do {
        audioPlayer = try AVAudioPlayer(data: soundFile.data)
        audioPlayer.play()
    } catch {
        print("😡 ERROR: -> \(error.localizedDescription) creating AVAudioPlayer")
    }
}

func stopSound() {
    if audioPlayer != nil && audioPlayer.isPlaying {
        audioPlayer.stop()
    }
}
