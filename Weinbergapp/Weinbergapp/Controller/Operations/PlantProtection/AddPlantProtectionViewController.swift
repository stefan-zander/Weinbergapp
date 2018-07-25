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

    var currentPlantProtectionKind = PlantProtectionKind.fungicidal(FungicidalPlantProtection())
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
            plantProtectionKind.text = PlantProtectionLocalization.localize(currentPlantProtectionKind)
            currentPesticides = plantProtection.pesticides
            pesticides.text = PlantProtectionLocalization.localize(currentPesticides)
            treatmentSchedule.selectRow(plantProtection.treatmentSchedule.rawValue, inComponent: 0, animated: false)
            additionalInformation.text = plantProtection.additionalInformation
            appliedAmount.text = String(plantProtection.appliedAmount)
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case plantProtectionKind:
            switch currentPlantProtectionKind {
            case .fungicidal(let fungicidal):
                PlantProtectionDialogs.open(fungicidal: fungicidal,
                                           controller: self,
                                           completion: { newFungicidal in
                    self.currentPlantProtectionKind = .fungicidal(newFungicidal)
                    self.plantProtectionKind.text = PlantProtectionLocalization.localize(newFungicidal)
                    })

            case .herbicide(let herbicide):
                PlantProtectionDialogs.open(herbicide: herbicide,
                                           controller: self,
                                           completion: { (newHerbicide) in
                    self.currentPlantProtectionKind = .herbicide(newHerbicide)
                    self.plantProtectionKind.text = PlantProtectionLocalization.localize(newHerbicide)
                    })

            case .insecticidalOrAcaricidal(let insecticidalOrAcaricidal):
                PlantProtectionDialogs.open(insecticidalOrAcaricidal: insecticidalOrAcaricidal,
                                           controller: self,
                                           completion: { (newInsecticidalOrAcaricidal) in
                    self.currentPlantProtectionKind = .insecticidalOrAcaricidal(insecticidalOrAcaricidal)
                    self.plantProtectionKind.text = PlantProtectionLocalization.localize(newInsecticidalOrAcaricidal)
                })

            }
        case pesticides:
            PlantProtectionDialogs.open(pesticides: self.currentPesticides, controller: self) { (newPesticides) in
                self.currentPesticides = newPesticides
                self.pesticides.text = PlantProtectionLocalization.localize(newPesticides)
            }
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
        if case PlantProtectionKind.fungicidal(_) = currentPlantProtectionKind {
            return
        }

        currentPlantProtectionKind = .fungicidal(FungicidalPlantProtection())
        plantProtectionKind.text = ""
    }

    @IBAction func herbicideClicked(_ sender: UIButton) {
        if case PlantProtectionKind.herbicide(_) = currentPlantProtectionKind {
            return
        }

        currentPlantProtectionKind = .herbicide(HerbicidePlantProtection())
        plantProtectionKind.text = ""
    }

    @IBAction func insecticidalOrAcaricidalClicked(_ sender: UIButton) {
        if case PlantProtectionKind.insecticidalOrAcaricidal(_) = currentPlantProtectionKind {
            return
        }

        currentPlantProtectionKind = .insecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection())
        plantProtectionKind.text = ""
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let field = OperationFieldVerification.verify(field: field, self) else { return }
        guard let user = OperationFieldVerification.verify(user: user, self) else { return }
        guard let workingHours = OperationFieldVerification.verify(workingHours: workingHours, self) else { return }

        guard let treatmentSchedule = PlantProtectionTreatmentSchedule(
            rawValue: treatmentSchedule.selectedRow(inComponent: 0)) else {
            assert(false)
            return
        }

        guard let appliedAmount = OperationFieldVerification.verify(appliedAmount: appliedAmount, self) else { return }

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
