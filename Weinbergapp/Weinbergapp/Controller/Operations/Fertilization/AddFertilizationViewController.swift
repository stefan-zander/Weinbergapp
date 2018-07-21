//
//  AddFertilizatinViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddFertilizationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var fertilizerCategory: UIPickerView!
    @IBOutlet weak var fertilizer: UIPickerView!
    @IBOutlet weak var appliedAmount: UITextField!

    var editIndex: Int?
    var source: FertilizationViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        fertilizerCategory.delegate = self
        fertilizerCategory.dataSource = self
        fertilizer.delegate = self
        fertilizer.dataSource = self

        if let editIndex = editIndex {
            let fertilization = source.fertilizations[editIndex]

            date.date = fertilization.date
            field.text = fertilization.field
            user.text = fertilization.user
            workingHours.text = String(fertilization.workingHours)
            currentFertilizier = fertilization.fertilizer
            appliedAmount.text = String(fertilization.appliedAmount)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case fertilizerCategory:
            return 2
        case fertilizer:
            return 8
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fertilizerCategory {
            fertilizer.reloadAllComponents()
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case fertilizerCategory:
            switch row {
            case 0:
                return "Mineralisch"
            case 1:
                return "Organisch"
            default:
                return nil
            }
        case fertilizer:
            switch fertilizerCategory.selectedRow(inComponent: 0) {
            case 0:
                return getMineralFertilizer(index: row)
            case 1:
                return getOrganicFertilizer(index: row)
            default:
                return nil
            }
        default:
            return nil
        }
    }

    func getMineralFertilizer(index: Int) -> String? {
        switch index {
        case 0:
            return "Entec perfekt"
        case 1:
            return "Entec 26"
        case 2:
            return "Hyperphosphat - fein (Rohphosphat)"
        case 3:
            return "Mg-Kalke"
        case 4:
            return "Kornkali mit MgO"
        case 5:
            return "Kalimagnesia (Parent-Kali)"
        case 6:
            return "Kaliumsulfat fein u. granuliert"
        case 7:
            return "Kalksalpeter"
        default:
            return nil
        }
    }

    func getOrganicFertilizer(index: Int) -> String? {
        switch index {
        case 0:
            return "Terragon"
        case 1:
            return "Weinhefen filtriert"
        case 2:
            return "Trester"
        case 3:
            return "Legehennen (22,5% TS)"
        case 4:
            return "Rinder"
        case 5:
            return "Bio(Abfall)kompost"
        case 6:
            return "Baumrinde (1m3 = 0,4 t)"
        case 7:
            return "Weinhefe Flüssig (1m² = 1t)"
        default:
            return nil
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let field = OperationVerification.verify(field: field, self) else { return }
        guard let user = OperationVerification.verify(user: user, self) else { return }
        guard let workingHours = OperationVerification.verify(workingHours: workingHours, self) else { return }
        guard let appliedAmount = OperationVerification.verify(appliedAmount: appliedAmount, self) else { return }

        guard let fertilizer = currentFertilizier else {
            assert(false)
            return
        }

        let fertilization = Fertilization(date: date.date,
                                          field: field,
                                          user: user,
                                          workingHours: workingHours,
                                          fertilizer: fertilizer,
                                          appliedAmount: appliedAmount)

        if let editIndex = editIndex {
            source.fertilizations[editIndex] = fertilization
        } else {
            source.fertilizations.append(fertilization)
        }

        source.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    var currentFertilizier: Fertilizer? {
        get {
            switch fertilizerCategory.selectedRow(inComponent: 0) {
            case 0:
                if let mineralFertilizier = MineralFertilizer(rawValue: fertilizer.selectedRow(inComponent: 0)) {
                    return .mineral(mineralFertilizier)
                }
            case 1:
                if let organicFertilizer = OrganicFertilizer(rawValue: fertilizer.selectedRow(inComponent: 0)) {
                    return .organic(organicFertilizer)
                }
            default:
                break
            }

            return nil
        }
        set(newFertilizer) {
            guard let newFertilizer = newFertilizer else {
                return
            }

            switch newFertilizer {
            case .mineral(let fertilizer):
                fertilizerCategory.selectRow(0, inComponent: 0, animated: false)
                self.fertilizer.selectRow(fertilizer.rawValue, inComponent: 0, animated: false)
            case .organic(let fertilizer):
                fertilizerCategory.selectRow(1, inComponent: 0, animated: false)
                self.fertilizer.selectRow(fertilizer.rawValue, inComponent: 0, animated: false)
            }
        }
    }
}
