//
//  MetronomeViewController.swift
//  tictoc
//
//  Created by Jun Keun Yi on 4/23/18.
//  Copyright © 2018 Kris. All rights reserved.
//

import UIKit

class MetronomeViewController: UIViewController {

    var met: AudioPlayer?
    
    @IBOutlet weak var bpmSetter: UIStepper!
    @IBOutlet weak var measureSetter: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initial configurations common to all metronomes
        bpmSetter.maximumValue = 330
        bpmSetter.minimumValue = 1
        bpmSetter.stepValue = 1
        measureSetter.maximumValue = 127
        measureSetter.minimumValue = 0
        measureSetter.stepValue = 1
        
        
        if met == nil {
            met = AudioPlayer()
        // set the values for the bpm
        bpmSetter.value = 60
        
        // set the values for the measure
        measureSetter.value = 0
        }
        
        bpmLabel.text = String(Int(bpmSetter.value))
        measureLabel.text = String(Int(measureSetter.value))
        beatTrackerLabel.text = "tap!"
    }
    
    
    @IBAction func pressedPlay(_ sender: UIButton) {
        if (!(met?.isPlaying())!) {
            met?.playRepeat(forBPM: Int16(bpmSetter.value), forDivisor: Int16(Int(measureSetter.value)))
        }
    }
    
    @IBAction func pressedStop(_ sender: UIButton) {
        if (met?.isPlaying())! {
            met?.stopSound()
        }
    }
    
    
    
    
    
    @IBOutlet weak var bpmLabel: UILabel!
    
    @IBAction func changedBPM(_ sender: UIStepper) {
        bpmLabel.text = String(Int(bpmSetter.value))
        if (met?.isPlaying())! {
            met?.stopSound()
            met?.playRepeat(forBPM: Int16(bpmSetter.value), forDivisor: Int16(Int(measureSetter.value)))
        }
    }
    
    
    @IBOutlet weak var measureLabel: UILabel!
    
    @IBAction func changedMeasure(_ sender: UIStepper) {
        measureLabel.text = String(Int(measureSetter.value))
        if (met?.isPlaying())! {
            met?.stopSound()
            met?.playRepeat(forBPM: Int16(bpmSetter.value), forDivisor: Int16(Int(measureSetter.value)))
        }
    }
    
    
    @IBOutlet weak var beatTrackerLabel: UILabel!
    @IBAction func pressedTracker(_ sender: UIButton) {
        met?.track(atHitTime: NSDate())
        if let beat = met?.retreiveBeat() {
            beatTrackerLabel.text = String(beat)
        } else {
            beatTrackerLabel.text = "tap!"
        }
    }
    


}



























