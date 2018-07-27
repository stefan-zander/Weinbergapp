//
//  AddPlantProtectionViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddPlantProtectionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate,
    UIPickerViewDataSource {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var plantProtectionKind: UITextField!
    @IBOutlet weak var pesticides: UITextField!
    @IBOutlet weak var treatmentSchedule: UIPickerView!
    @IBOutlet weak var additionalInformation: UITextView!
    @IBOutlet weak var appliedAmount: UITextField!
    
    var currentCategory = PlantProtectionCategory.fungicidal
    var currentFungicidal = FungicidalPlantProtection()
    var currentHerbicide = HerbicidePlantProtection()
    var currentInsecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection()
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
            applyChanges(from: source.plantProtections[editIndex])
        }
    }
    
    func applyChanges(from: PlantProtection) {
        date.date = from.date
        field.text = from.field
        user.text = from.user
        workingHours.text = String(from.workingHours)
        currentCategory = from.plantProtectionCategory
        
        if let fungicidal = from.fungicidalPlantProtection {
            currentFungicidal.copy(from: fungicidal)
        }
        
        if let herbicide = from.herbicidePlantProtection {
            currentHerbicide.copy(from: herbicide)
        }
        
        if let insecticidalOrAcaricidal = from.insecticidalOrAcaricidalPlantProtection {
            currentInsecticidalOrAcaricidal.copy(from: insecticidalOrAcaricidal)
        }
        
        if let pesticides = from.pesticides {
            currentPesticides.copy(from: pesticides)
        }
        
        treatmentSchedule.selectRow(from.treatmentScheduleRaw, inComponent: 0, animated: false)
        additionalInformation.text = from.additionalInformation
        appliedAmount.text = String(from.appliedAmount)
    }
    
    func applyChanges(to: PlantProtection) {
        to.date = date.date
        to.field = field.text ?? ""
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
        to.plantProtectionCategory = currentCategory
        
        if let fungicidal = to.fungicidalPlantProtection {
            currentFungicidal.copy(to: fungicidal)
        } else {
            let fungicidal = FungicidalPlantProtection()
            currentFungicidal.copy(to: fungicidal)
            to.fungicidalPlantProtection = fungicidal
        }
        
        if let herbicide = to.herbicidePlantProtection {
            currentHerbicide.copy(to: herbicide)
        } else {
            let herbicide = HerbicidePlantProtection()
            currentHerbicide.copy(to: herbicide)
            to.herbicidePlantProtection = herbicide
        }
        
        if let insecticidalOrAcaricidal = to.insecticidalOrAcaricidalPlantProtection {
            currentInsecticidalOrAcaricidal.copy(to: insecticidalOrAcaricidal)
        } else {
            let insecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection()
            currentInsecticidalOrAcaricidal.copy(to: insecticidalOrAcaricidal)
            to.insecticidalOrAcaricidalPlantProtection = insecticidalOrAcaricidal
        }
        
        if let pesticides = to.pesticides {
            currentPesticides.copy(to: pesticides)
        } else {
            let pesticides = PlantProtectionPesticides()
            currentPesticides.copy(to: pesticides)
            to.pesticides = pesticides
        }
        
        to.treatmentScheduleRaw = treatmentSchedule.selectedRow(inComponent: 0)
        to.additionalInformation = additionalInformation.text        
        to.appliedAmount = Double(appliedAmount.text ?? "0") ?? 0.0
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case plantProtectionKind:
            switch currentCategory {
            case .fungicidal:
                PlantProtectionDialogs.open(fungicidal: currentFungicidal,
                                            controller: self,
                                            completion: {
                    self.plantProtectionKind.text =
                        PlantProtectionLocalization.localize(self.currentFungicidal)
                })

            case .herbicide:
                PlantProtectionDialogs.open(herbicide: currentHerbicide,
                                           controller: self,
                                           completion: {
                    self.plantProtectionKind.text =
                        PlantProtectionLocalization.localize(self.currentHerbicide)
                    })

            case .insecticidalOrAcaricidal:
                PlantProtectionDialogs.open(insecticidalOrAcaricidal: currentInsecticidalOrAcaricidal,
                                           controller: self,
                                           completion: {
                    self.plantProtectionKind.text =
                        PlantProtectionLocalization.localize(self.currentInsecticidalOrAcaricidal)
                })
            }
        case pesticides:
            PlantProtectionDialogs.open(pesticides: self.currentPesticides,
                                        controller: self,
                                        completion: {
                self.pesticides.text =
                    PlantProtectionLocalization.localize(self.currentPesticides)
            })
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
        return PlantProtectionLocalization.getTreatmentSchedule(index: row)
    }

    @IBAction func fungicidalClicked(_ sender: UIButton) {
        currentCategory = .fungicidal
        plantProtectionKind.text = PlantProtectionLocalization.localize(currentFungicidal)
    }

    @IBAction func herbicideClicked(_ sender: UIButton) {
        currentCategory = .herbicide
        plantProtectionKind.text = PlantProtectionLocalization.localize(currentHerbicide)
    }

    @IBAction func insecticidalOrAcaricidalClicked(_ sender: UIButton) {
        currentCategory = .insecticidalOrAcaricidal
        plantProtectionKind.text = PlantProtectionLocalization.localize(currentInsecticidalOrAcaricidal)
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationFieldVerification.verify(field: field, self) else { return }
        guard OperationFieldVerification.verify(user: user, self) else { return }
        guard OperationFieldVerification.verify(workingHours: workingHours, self) else { return }
        guard OperationFieldVerification.verify(appliedAmount: appliedAmount, self) else { return }
        
        do {
            if let editIndex = editIndex {
                let plantProtection = source.plantProtections[editIndex]
                
                try source.dataSource.update {
                    applyChanges(to: plantProtection)
                }
            } else {
                let plantProtection = PlantProtection()
                applyChanges(to: plantProtection)
                
                try source.dataSource.add(plantProtection)
                source.plantProtections.append(plantProtection)
            }
            
            source.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            OperationDialogs.presentSaveFailed(error: error, controller: self)
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
