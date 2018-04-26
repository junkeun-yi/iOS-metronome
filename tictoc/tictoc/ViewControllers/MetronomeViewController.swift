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
    var initBPM: Int16 = 80
    var initMeasure: Int16 = 0
    var initName: String? = "Untitled"
    var saveIndex: Int?
    
    @IBOutlet weak var fileName: UITextField!
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
        }
        // set the values for the bpm and measure
        bpmSetter.value = Double(initBPM)
        measureSetter.value = Double(initMeasure)
        fileName.text = initName
        
        bpmLabel.text = String(Int(bpmSetter.value))
        measureLabel.text = String(Int(measureSetter.value))
        beatTrackerLabel.text = "tap!"
    }
    
    
    @IBAction func saveTheFile(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        if let index = saveIndex {
            let thisSave = saveFiles[index]
            context.delete(thisSave)
        }
        let mySave = SaveFile(context: context)
        mySave.name = fileName.text
        mySave.bpm = Int16(bpmSetter.value)
        mySave.divisor = Int16(measureSetter.value)
        appDel.saveContext()
        let alert = UIAlertController(title: "Your file was saved", message: "Hoorah", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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



























