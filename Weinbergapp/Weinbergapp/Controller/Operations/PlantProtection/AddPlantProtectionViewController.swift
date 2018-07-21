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

    private func openDialog(_ fungicidal: FungicidalPlantProtection) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Botrytis", fungicidal.botrytis),
                ("Essigfäule", fungicidal.acidRot),
                ("Oidium", fungicidal.oidium),
                ("Peronospora", fungicidal.peronospora),
                ("Phomopsis", fungicidal.phomopsis),
                ("Roter Brenner", fungicidal.redBurner)
                ])

            switchTable.completion = {
                self.currentPlantProtectionKind = .fungicidal(
                    FungicidalPlantProtection(
                        botrytis: switchTable.getItemState(index: 0),
                        acidRot: switchTable.getItemState(index: 1),
                        oidium: switchTable.getItemState(index: 2),
                        peronospora: switchTable.getItemState(index: 3),
                        phomopsis: switchTable.getItemState(index: 4),
                        redBurner: switchTable.getItemState(index: 5)))

                self.plantProtectionKind.text =
                    PlantProtectionLocalization.localize(self.currentPlantProtectionKind)
            }

            present(switchTable, animated: true, completion: nil)
        }
    }

    private func openDialog(_ herbicide: HerbicidePlantProtection) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Ackerwinde", herbicide.bindweed),
                ("Ein- und Zweikeimblättrige", herbicide.monocotyledonousAndDicotyledonous)
                ])

            switchTable.completion = {
                self.currentPlantProtectionKind = .herbicide(
                    HerbicidePlantProtection(
                        bindweed: switchTable.getItemState(index: 0),
                        monocotyledonousAndDicotyledonous: switchTable.getItemState(index: 1)))

                self.plantProtectionKind.text =
                    PlantProtectionLocalization.localize(self.currentPlantProtectionKind)
            }

            present(switchTable, animated: true, completion: nil)
        }
    }

    private func openDialog(_ insecticidalOrAcaricidal: InsecticidalOrAcaricidalPlantProtection) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Drosophila-Arten", insecticidalOrAcaricidal.drosophilaSpecies),
                ("Kräuselmilben", insecticidalOrAcaricidal.grapevineRustMites),
                ("Rhombenspanner", insecticidalOrAcaricidal.willowBeauty),
                ("Spinnmilben", insecticidalOrAcaricidal.spiderMites),
                ("Springwurm", insecticidalOrAcaricidal.springWorm),
                ("Traubenwickler (Heu- und Sauerwurm)", insecticidalOrAcaricidal.grape),
                ("Zikaden", insecticidalOrAcaricidal.cicadas)
                ])

            switchTable.completion = {
                self.currentPlantProtectionKind = .insecticidalOrAcaricidal(
                    InsecticidalOrAcaricidalPlantProtection(
                        drosophilaSpecies: switchTable.getItemState(index: 0),
                        grapevineRustMites: switchTable.getItemState(index: 1),
                        willowBeauty: switchTable.getItemState(index: 2),
                        spiderMites: switchTable.getItemState(index: 3),
                        springWorm: switchTable.getItemState(index: 4),
                        grape: switchTable.getItemState(index: 5),
                        cicadas: switchTable.getItemState(index: 6)))

                self.plantProtectionKind.text =
                    PlantProtectionLocalization.localize(self.currentPlantProtectionKind)
            }

            present(switchTable, animated: true, completion: nil)
        }
    }

    private func openDialog(_ pesticides: PlantProtectionPesticides) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Botector", pesticides.botector),
                ("Cantus", pesticides.cantus),
                ("Gibbb 3", pesticides.gibbb3),
                ("Melody Combi", pesticides.melodyCombi),
                ("Prolectus", pesticides.prolectus),
                ("Pyrus; Babel", pesticides.pyrusBabel),
                ("Regalis Plus", pesticides.regalisPlus),
                ("Scala", pesticides.scala),
                ("Switch", pesticides.`switch`),
                ("Teldor", pesticides.teldor)
                ])

            switchTable.completion = {
                self.currentPesticides = PlantProtectionPesticides(
                    botector: switchTable.getItemState(index: 0),
                    cantus: switchTable.getItemState(index: 1),
                    gibbb3: switchTable.getItemState(index: 2),
                    melodyCombi: switchTable.getItemState(index: 3),
                    prolectus: switchTable.getItemState(index: 4),
                    pyrusBabel: switchTable.getItemState(index: 5),
                    regalisPlus: switchTable.getItemState(index: 6),
                    scala: switchTable.getItemState(index: 7),
                    switch: switchTable.getItemState(index: 8),
                    teldor: switchTable.getItemState(index: 9))

                self.pesticides.text = PlantProtectionLocalization.localize(self.currentPesticides)
            }

            present(switchTable, animated: true, completion: nil)
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case plantProtectionKind:
            switch currentPlantProtectionKind {
            case .fungicidal(let fungicidal):
                openDialog(fungicidal)
            case .herbicide(let herbicide):
                openDialog(herbicide)
            case .insecticidalOrAcaricidal(let insecticidalOrAcaricidal):
                openDialog(insecticidalOrAcaricidal)
            }
        case pesticides:
            openDialog(currentPesticides)
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
        guard let field = OperationVerification.verify(field: field, self) else { return }
        guard let user = OperationVerification.verify(user: user, self) else { return }
        guard let workingHours = OperationVerification.verify(workingHours: workingHours, self) else { return }

        guard let treatmentSchedule = PlantProtectionTreatmentSchedule(
            rawValue: treatmentSchedule.selectedRow(inComponent: 0)) else {
            assert(false)
            return
        }

        guard let appliedAmount = OperationVerification.verify(appliedAmount: appliedAmount, self) else { return }

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
