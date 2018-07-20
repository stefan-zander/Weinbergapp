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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantProtectionKind.delegate = self
        pesticides.delegate = self
        
        treatmentSchedule.delegate = self
        treatmentSchedule.dataSource = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case plantProtectionKind:
            let storyboard = UIStoryboard(name: "View", bundle: nil)
            let sv = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            
            if let sv = sv as? SwitchTableViewController {
                switch currentPlantProtectionKind {
                case PlantProtectionKind.Fungicidal(let fungicidal):
                    sv.setItems(items: [
                        ("Botrytis", fungicidal.botrytis),
                        ("Essigfäule", fungicidal.acidRot),
                        ("Oidium", fungicidal.oidium),
                        ("Peronospora", fungicidal.peronospora),
                        ("Phomopsis", fungicidal.phomopsis),
                        ("Roter Brenner", fungicidal.redBurner)
                        ])
                    
                    sv.completion = {
                        self.currentPlantProtectionKind = .Fungicidal(FungicidalPlantProtection(
                            botrytis: sv.getItemState(index: 0),
                            acidRot: sv.getItemState(index: 1),
                            oidium: sv.getItemState(index: 2),
                            peronospora: sv.getItemState(index: 3),
                            phomopsis: sv.getItemState(index: 4),
                            redBurner: sv.getItemState(index: 5)
                        ))
                    }
                    
                case .Herbicide(let herbicide):
                    sv.setItems(items: [
                        ("Ackerwinde", herbicide.bindweed),
                        ("Ein- und Zweikeimblättrige", herbicide.monocotyledonousAndDicotyledonous)
                        ])
                    
                    sv.completion = {
                        self.currentPlantProtectionKind = .Herbicide(HerbicidePlantProtection(
                            bindweed: sv.getItemState(index: 0),
                            monocotyledonousAndDicotyledonous: sv.getItemState(index: 1)
                        ))
                    }
                    
                case .InsecticidalOrAcaricidal(let insecticidalOrAcaricidal):
                    sv.setItems(items: [
                        ("Drosophila-Arten", insecticidalOrAcaricidal.drosophilaSpecies),
                        ("Kräuselmilben", insecticidalOrAcaricidal.grapevineRustMites),
                        ("Rhombenspanner", insecticidalOrAcaricidal.willowBeauty),
                        ("Spinnmilben", insecticidalOrAcaricidal.spiderMites),
                        ("Springwurm", insecticidalOrAcaricidal.springWorm),
                        ("Traubenwickler (Heu- und Sauerwurm)", insecticidalOrAcaricidal.grape),
                        ("Zikaden", insecticidalOrAcaricidal.cicadas)])
                    
                    sv.completion = {
                        self.currentPlantProtectionKind = .InsecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection(
                            drosophilaSpecies: sv.getItemState(index: 0),
                            grapevineRustMites: sv.getItemState(index: 1),
                            willowBeauty: sv.getItemState(index: 2),
                            spiderMites: sv.getItemState(index: 3),
                            springWorm: sv.getItemState(index: 4),
                            grape: sv.getItemState(index: 5),
                            cicadas: sv.getItemState(index: 6)
                        ))
                    }
                }
            }
            
            present(sv, animated: true, completion: nil)
        case pesticides:
            break
        default:
            break
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
