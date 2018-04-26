//
//  AudioPlayer.swift
//  tictoc
//
//  Created by Jun Keun Yi on 4/23/18.
//  Copyright © 2018 Kris. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation

class AudioPlayer {
    
    let ticSound = Bundle.main.url(forResource: "drumkit1-1", withExtension: "wav", subdirectory: "Audio_Files/drum_kit_1")
    let tocSound = Bundle.main.url(forResource: "drumkit1-3", withExtension: "wav", subdirectory: "Audio_Files/drum_kit_1")
    var ticPlayer: AVAudioPlayer?
    let tocPlayer: AVAudioPlayer?
    var timer: Timer?
    
    var tapTime: NSDate = NSDate()
    var tapTrack: [NSDate] = []
    
    var bpm: TimeInterval?
    var divisor: Int8?
    
    var cnt: Int8 = 1
    let sampleNum: Int = 2
    
    var soundOn: Bool = false
    
    init() {
        // bpm = beat
        // divisor = divis
        do {
            try ticPlayer = AVAudioPlayer(contentsOf: ticSound!)
            try tocPlayer = AVAudioPlayer(contentsOf: tocSound!)
            ticPlayer?.prepareToPlay()
            tocPlayer?.prepareToPlay()
        } catch {
            ticPlayer = nil
            tocPlayer = nil
        }
    }
    
    func playRepeat(forBPM beat: Int16, forDivisor divis: Int8) {
        bpm = (1 / (Double(beat) / 60.0))
        divisor = divis
        timer = Timer.scheduledTimer(timeInterval: bpm!, target: self, selector: #selector(playSound), userInfo: nil, repeats: true)
        timer?.fire()
        soundOn = true
    }

    @objc func playSound() {
        if cnt < divisor! {
            ticPlayer?.play()
            cnt += 1
        } else if cnt == divisor {
            tocPlayer?.play()
            cnt = 1
        } else {
            ticPlayer?.play()
            cnt = 1
        }
    }
    
    func stopSound() {
        timer?.invalidate()
        ticPlayer?.prepareToPlay()
        tocPlayer?.prepareToPlay()
        soundOn = false
    }
    
    func isPlaying() -> Bool {
        return soundOn
    }
    
    
    //tracks each tap to do things
    func track(atHitTime time: NSDate) {
        if (tapTrack.count > 0) {
            if (NSDate().timeIntervalSince(tapTrack[tapTrack.count - 1] as Date) > 5.0) {
                tapTrack = []
            }
        }
        tapTrack.append(time)
    }
    
    func retreiveBeat() -> Double? {
        if tapTrack.count < sampleNum {
            return nil
        } else {
            var sum = 0.0
            var found = 0.0
            for i in (tapTrack.count - sampleNum - 1)..<(tapTrack.count) {
                found = Double(tapTrack[i].timeIntervalSince(tapTrack[i - 1] as Date))
                sum += found
            }
            return (1.0 / (sum / Double(sampleNum))) * 60.0
        }
    }
    
    

    
    
    
}

