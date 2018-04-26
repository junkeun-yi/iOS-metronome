//
//  SaveFilePickerViewController.swift
//  tictoc
//
//  Created by Jun Keun Yi on 4/25/18.
//  Copyright © 2018 Kris. All rights reserved.
//

import UIKit

class saveCell: UITableViewCell {
    @IBOutlet weak var saveFileName: UILabel!
}

class SaveFilePickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var saveTableView: UITableView!
    
    let cellHeight: CGFloat = 100
    var selectedSave: Int?

    
    var createNew: Bool = false
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "saveFileCell") as? saveCell {
            if let saveNameLabel = saveFiles[indexPath.row].name {
                cell.saveFileName.text = saveNameLabel
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSave = indexPath.row
        performSegue(withIdentifier: "segueToMet", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let thisSave = saveFiles[indexPath.row]
            context.delete(thisSave)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            fetchSaveFilesFromCoreData()
        }
        tableView.reloadData()
    }
    
    
    @IBAction func createNewMet(_ sender: UIButton) {
        createNew = true
        performSegue(withIdentifier: "segueToMet", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSaveFilesFromCoreData()
        self.saveTableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveTableView.delegate = self
        saveTableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }

    func fetchSaveFilesFromCoreData() {
        do {
            saveFiles = try context.fetch(SaveFile.fetchRequest())
        } catch {
            print("No Saves")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "segueToMet" {
                if let dest = segue.destination as? MetronomeViewController {
                    if (createNew == false) {
                        dest.met = AudioPlayer()
                        dest.initBPM = saveFiles[selectedSave!].bpm
                        dest.initMeasure = saveFiles[selectedSave!].divisor
                        dest.initName = saveFiles[selectedSave!].name
                        dest.saveIndex = selectedSave
                    } else {
                        createNew = false
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
