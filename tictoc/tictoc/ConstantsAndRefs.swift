//
//  ConstantsAndRefs.swift
//  tictoc
//
//  Created by Jun Keun Yi on 4/18/18.
//  Copyright © 2018 Kris. All rights reserved.
//

import Foundation

var saveFiles: [SaveFile] = []




func delayX(time: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        closure()
    }
}
