//
//  AddPlantProtectionViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddPlantProtectionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate,
    UIPickerViewDataSource {

    public var onLoad: (() -> Void)?
    public var onSave: (() -> Bool)?

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UIPickerView!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var plantProtectionKind: UITextField!
    @IBOutlet weak var pesticides: UITextField!
    @IBOutlet weak var treatmentSchedule: UIPickerView!
    @IBOutlet weak var additionalInformation: UITextView!
    @IBOutlet weak var appliedAmount: UITextField!

    var fields: MapFieldCollection!
    
    var currentCategory = PlantProtectionCategory.fungicidal
    var currentFungicidal = FungicidalPlantProtection()
    var currentHerbicide = HerbicidePlantProtection()
    var currentInsecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection()
    var currentPesticides = PlantProtectionPesticides()

    override func viewDidLoad() {
        super.viewDidLoad()

        plantProtectionKind.delegate = self
        pesticides.delegate = self
        treatmentSchedule.delegate = self
        treatmentSchedule.dataSource = self

        if let onLoad = onLoad {
            onLoad()
        }
    }

    public func applyChanges(from: PlantProtection) {
        date.date = from.date
        
        if let index = fields.index(of: from.field!) {
            field.selectRow(index, inComponent: 0, animated: false)
        }
        
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

        switch currentCategory {
        case .fungicidal:
            plantProtectionKind.text = PlantProtectionLocalization.localize(currentFungicidal)
        case .herbicide:
            plantProtectionKind.text = PlantProtectionLocalization.localize(currentHerbicide)
        case .insecticidalOrAcaricidal:
            plantProtectionKind.text = PlantProtectionLocalization.localize(currentInsecticidalOrAcaricidal)
        }

        if let pesticides = from.pesticides {
            currentPesticides.copy(from: pesticides)
            self.pesticides.text = PlantProtectionLocalization.localize(pesticides)
        }

        treatmentSchedule.selectRow(from.treatmentScheduleRaw, inComponent: 0, animated: false)
        additionalInformation.text = from.additionalInformation
        appliedAmount.text = String(from.appliedAmount)
    }

    public func applyChanges(to: PlantProtection) {
        to.date = date.date
        to.field = fields[field.selectedRow(inComponent: 0)]
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
            PlantProtectionDialogs.presentPlantProtection(controller: self)
        case pesticides:
            PlantProtectionDialogs.presentPesticides(controller: self)
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
        return PlantProtectionLocalization.treatmentScheduleOptions[row]
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
        guard OperationFieldVerification.verify(user: user, self) else { return }
        guard OperationFieldVerification.verify(workingHours: workingHours, self) else { return }
        guard OperationFieldVerification.verify(appliedAmount: appliedAmount, self) else { return }

        if let onSave = onSave {
            guard onSave() else { return }
        }

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
