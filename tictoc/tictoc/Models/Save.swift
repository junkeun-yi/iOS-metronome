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
    
    
    func changeBPM(toNum num: Int16) {
        bpm = num
    }
    
    func changeDivisor(toNum num: Int8) {
        divisor = num
    }
    
    
    
    
    
}
