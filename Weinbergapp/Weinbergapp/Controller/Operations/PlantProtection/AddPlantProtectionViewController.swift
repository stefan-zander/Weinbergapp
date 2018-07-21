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
    @IBOutlet weak var plantProtectionKind: UITextField!
    @IBOutlet weak var pesticides: UITextField!
    @IBOutlet weak var treatmentSchedule: UIPickerView!
    @IBOutlet weak var additionalInformation: UITextView!
    @IBOutlet weak var appliedAmount: UITextField!
    
    var currentPlantProtectionKind = PlantProtectionKind.Fungicidal(FungicidalPlantProtection())
    var currentPesticides = PlantProtectionPesticides()
    
    var editIndex: Int?
    var source: PlantProtectionViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantProtectionKind.delegate = self
        pesticides.delegate = self
        treatmentSchedule.delegate = self
        treatmentSchedule.dataSource = self
        
        if let editIndex = editIndex {
            let plantProtection = source.plantProtections[editIndex]
            
            date.date = plantProtection.date
            field.text = plantProtection.field
            user.text = plantProtection.user
            workingHours.text = String(plantProtection.workingHours)
            currentPlantProtectionKind = plantProtection.plantProtectionKind
            plantProtectionKind.text = PlantProtectionLocalization.localizePlantProtectionKind(currentPlantProtectionKind)
            currentPesticides = plantProtection.pesticides
            pesticides.text = PlantProtectionLocalization.localizePesticides(currentPesticides)
            treatmentSchedule.selectRow(plantProtection.treatmentSchedule.rawValue, inComponent: 0, animated: false)
            additionalInformation.text = plantProtection.additionalInformation
            appliedAmount.text = String(plantProtection.appliedAmount)
        }
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
                        
                        self.plantProtectionKind.text = PlantProtectionLocalization.localizePlantProtectionKind(self.currentPlantProtectionKind)
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
                        
                        self.plantProtectionKind.text = PlantProtectionLocalization.localizePlantProtectionKind(self.currentPlantProtectionKind)
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
                        
                        self.plantProtectionKind.text = PlantProtectionLocalization.localizePlantProtectionKind(self.currentPlantProtectionKind)
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
                    
                    self.pesticides.text = PlantProtectionLocalization.localizePesticides(self.currentPesticides)
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
        
        self.pesticides.text = "haha"
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
        guard let field = field.text, !field.isEmpty else {
            let alert = UIAlertController(title: "Feld nicht angegeben", message: "Das Feld darf nicht leer sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let user = user.text, !user.isEmpty else {
            let alert = UIAlertController(title: "Benutzer nicht angegeben", message: "Der Benuzter darf nicht leer sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let workingHoursText = workingHours.text, !workingHoursText.isEmpty else {
            let alert = UIAlertController(title: "Arbeitsstunden nicht angegeben", message: "Die Arbeitsstunden müssen angegeben sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let workingHours = Double(workingHoursText) else {
            let alert = UIAlertController(title: "Arbeitsstunden ist keine Zahl", message: "Bei der Angabe von Arbeitsstunden sind nur Zahlen zugelassen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let treatmentSchedule = PlantProtectionTreatmentSchedule(rawValue: treatmentSchedule.selectedRow(inComponent: 0)) else {
            assert(false)
            return
        }
        
        guard let appliedAmountText = appliedAmount.text, !appliedAmountText.isEmpty else {
            let alert = UIAlertController(title: "Ausgegebene Menge nicht angegeben", message: "Die ausgegebene Menge muss angegeben sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let appliedAmount = Double(appliedAmountText) else {
            let alert = UIAlertController(title: "Ausgegebene Menge ist keine Zahl", message: "Bei der Angabe von der ausgegebene Menge sind nur Zahlen zugelassen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        let plantProtection = PlantProtection(
            date: date.date,
            field: field,
            user: user,
            workingHours: workingHours,
            plantProtectionKind: currentPlantProtectionKind,
            pesticides: currentPesticides,
            treatmentSchedule: treatmentSchedule,
            additionalInformation: additionalInformation.text,
            appliedAmount: appliedAmount)
        
        if let editIndex = editIndex {
            source.plantProtections[editIndex] = plantProtection
        } else {
            source.plantProtections.append(plantProtection)
        }
        
        source.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
