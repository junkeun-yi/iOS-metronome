//
//  Save.swift
//  tictoc
//
//  Created by Jun Keun Yi on 4/18/18.
//  Copyright © 2018 Kris. All rights reserved.
//

import Foundation

class Save {
    
    var bpm: Int16 = 60 // up to 2^15 - 1
    var divisor: Int8 = 4 // up to 2^7 - 1
    var tapTime: NSDate = NSDate()
    var tapTrack: [NSDate] = []
    
    func changBPM(toNum num: Int16) {
        bpm = num
    }
    
    func changeDivisor(toNum num: Int8) {
        divisor = num
    }
    
    func trackNum(atHitTime time: NSDate) {
        tapTrack.append(time)
    }
    
    func retreiveTapTime() -> Int16? {
        if tapTrack.count < 4 {
            return nil
        } else {
            var timePassed: [Int] = []
            for i in 0..<(tapTrack.count - 1) {
                timePassed.append(Int(tapTrack[i].compare(tapTrack[i + 1] as Date)))
            }
        }
    }
    
    
    
    
}
