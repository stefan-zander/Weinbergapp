//
//  AddPlantProtectionViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddPlantProtectionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var appliedAmount: UITextField!
    @IBOutlet weak var plantProtectionKind: UITextField!
    @IBOutlet weak var pesticides: UITextField!
    @IBOutlet weak var treatmentSchedule: UIPickerView!
    @IBOutlet weak var additionalInformation: UITextView!
    
    var currentPlantProtectionKind = PlantProtectionKind.Fungicidal(FungicidalPlantProtection())
    var currentPesticides = PlantProtectionPesticides()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantProtectionKind.delegate = self
        pesticides.delegate = self
        
        treatmentSchedule.delegate = self
        treatmentSchedule.dataSource = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let storyboard = UIStoryboard(name: "View", bundle: nil)
        
        if let sw = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController") as? SwitchTableViewController {
            switch textField {
            case plantProtectionKind:
                switch currentPlantProtectionKind {
                case PlantProtectionKind.Fungicidal(let fungicidal):
                    sw.setItems(items: [
                        ("Botrytis", fungicidal.botrytis),
                        ("Essigfäule", fungicidal.acidRot),
                        ("Oidium", fungicidal.oidium),
                        ("Peronospora", fungicidal.peronospora),
                        ("Phomopsis", fungicidal.phomopsis),
                        ("Roter Brenner", fungicidal.redBurner)
                        ])
                    
                    sw.completion = {
                        self.currentPlantProtectionKind = .Fungicidal(FungicidalPlantProtection(
                            botrytis: sw.getItemState(index: 0),
                            acidRot: sw.getItemState(index: 1),
                            oidium: sw.getItemState(index: 2),
                            peronospora: sw.getItemState(index: 3),
                            phomopsis: sw.getItemState(index: 4),
                            redBurner: sw.getItemState(index: 5)
                        ))
                    }
                    
                case .Herbicide(let herbicide):
                    sw.setItems(items: [
                        ("Ackerwinde", herbicide.bindweed),
                        ("Ein- und Zweikeimblättrige", herbicide.monocotyledonousAndDicotyledonous)
                        ])
                    
                    sw.completion = {
                        self.currentPlantProtectionKind = .Herbicide(HerbicidePlantProtection(
                            bindweed: sw.getItemState(index: 0),
                            monocotyledonousAndDicotyledonous: sw.getItemState(index: 1)
                        ))
                    }
                    
                case .InsecticidalOrAcaricidal(let insecticidalOrAcaricidal):
                    sw.setItems(items: [
                        ("Drosophila-Arten", insecticidalOrAcaricidal.drosophilaSpecies),
                        ("Kräuselmilben", insecticidalOrAcaricidal.grapevineRustMites),
                        ("Rhombenspanner", insecticidalOrAcaricidal.willowBeauty),
                        ("Spinnmilben", insecticidalOrAcaricidal.spiderMites),
                        ("Springwurm", insecticidalOrAcaricidal.springWorm),
                        ("Traubenwickler (Heu- und Sauerwurm)", insecticidalOrAcaricidal.grape),
                        ("Zikaden", insecticidalOrAcaricidal.cicadas)
                        ])
                    
                    sw.completion = {
                        self.currentPlantProtectionKind = .InsecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection(
                            drosophilaSpecies: sw.getItemState(index: 0),
                            grapevineRustMites: sw.getItemState(index: 1),
                            willowBeauty: sw.getItemState(index: 2),
                            spiderMites: sw.getItemState(index: 3),
                            springWorm: sw.getItemState(index: 4),
                            grape: sw.getItemState(index: 5),
                            cicadas: sw.getItemState(index: 6)
                        ))
                    }
                }
            case pesticides:
                sw.setItems(items: [
                    ("Botector", currentPesticides.botector),
                    ("Cantus", currentPesticides.cantus),
                    ("Gibbb 3", currentPesticides.gibbb3),
                    ("Melody Combi", currentPesticides.melodyCombi),
                    ("Prolectus", currentPesticides.prolectus),
                    ("Pyrus; Babel", currentPesticides.pyrusBabel),
                    ("Regalis Plus", currentPesticides.regalisPlus),
                    ("Scala", currentPesticides.scala),
                    ("Switch", currentPesticides.`switch`),
                    ("Teldor", currentPesticides.teldor)
                    ])
                
                sw.completion = {
                    self.currentPesticides = PlantProtectionPesticides(
                        botector: sw.getItemState(index: 0),
                        cantus: sw.getItemState(index: 1),
                        gibbb3: sw.getItemState(index: 2),
                        melodyCombi: sw.getItemState(index: 3),
                        prolectus: sw.getItemState(index: 4),
                        pyrusBabel: sw.getItemState(index: 5),
                        regalisPlus: sw.getItemState(index: 6),
                        scala: sw.getItemState(index: 7),
                        switch: sw.getItemState(index: 8),
                        teldor: sw.getItemState(index: 9))
                }
                break
            default:
                break
            }
            
            present(sw, animated: true, completion: nil)
        }
        
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Austrieb"
        case 1:
            return "Vorblüte"
        case 2:
            return "1. Vorblüte"
        case 3:
            return "2. Vorblüte"
        case 4:
            return "3. Vorblüte"
        case 5:
            return "Abgehende Blüte"
        case 6:
            return "2. Nachblüte"
        case 7:
            return "3. Nachblüte"
        default:
            return nil
        }
    }
    
    @IBAction func fungicidalClicked(_ sender: UIButton) {
        if case PlantProtectionKind.Fungicidal(_) = currentPlantProtectionKind {
            return
        }
        
        currentPlantProtectionKind = .Fungicidal(FungicidalPlantProtection())
        plantProtectionKind.text = ""
    }
    
    @IBAction func herbicideClicked(_ sender: UIButton) {
        if case PlantProtectionKind.Herbicide(_) = currentPlantProtectionKind {
            return
        }
        
        currentPlantProtectionKind = .Herbicide(HerbicidePlantProtection())
        plantProtectionKind.text = ""
    }
    
    @IBAction func insecticidalOrAcaricidalClicked(_ sender: UIButton) {
        if case PlantProtectionKind.InsecticidalOrAcaricidal(_) = currentPlantProtectionKind {
            return
        }
        
        currentPlantProtectionKind = .InsecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection())
        plantProtectionKind.text = ""
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
