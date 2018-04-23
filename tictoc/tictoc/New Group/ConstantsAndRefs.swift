//
//  ConstantsAndRefs.swift
//  tictoc
//
//  Created by Jun Keun Yi on 4/18/18.
//  Copyright © 2018 Kris. All rights reserved.
//

import Foundation

func delay(time: Double, closure:()->()) {
    
    DispatchQueue.main.after(when: .now() + time) {
        closure()
    }
    
}
