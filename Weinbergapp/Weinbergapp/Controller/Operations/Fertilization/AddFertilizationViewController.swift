//
//  AddFertilizatinViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddFertilizationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    public var onLoad: (() -> Void)?
    public var onSave: (() -> Bool)?

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var fertilizerCategory: UIPickerView!
    @IBOutlet weak var fertilizer: UIPickerView!
    @IBOutlet weak var appliedAmount: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        fertilizerCategory.delegate = self
        fertilizerCategory.dataSource = self
        fertilizer.delegate = self
        fertilizer.dataSource = self

        if let onLoad = onLoad {
            onLoad()
        }
    }

    public func applyChanges(from: Fertilization) {
        date.date = from.date
        field.text = from.field
        user.text = from.user
        workingHours.text = String(from.workingHours)
        fertilizerCategory.selectRow(from.fertilizerCategoryRaw, inComponent: 0, animated: false)

        switch from.fertilizerCategoryRaw {
        case 0:
            fertilizer.selectRow(from.mineralFertilizerRaw, inComponent: 0, animated: false)
        case 1:
            fertilizer.selectRow(from.organicFertilizerRaw, inComponent: 0, animated: false)
        default:
            break
        }

        appliedAmount.text = String(from.appliedAmount)
    }

    public func applyChanges(to: Fertilization) {
        to.date = date.date
        to.field = field.text ?? ""
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
        to.fertilizerCategoryRaw = fertilizerCategory.selectedRow(inComponent: 0)

        switch to.fertilizerCategoryRaw {
        case 0:
            to.mineralFertilizerRaw = fertilizer.selectedRow(inComponent: 0)
        case 1:
            to.organicFertilizerRaw = fertilizer.selectedRow(inComponent: 0)
        default:
            break
        }

        to.appliedAmount = Double(appliedAmount.text ?? "0") ?? 0.0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case fertilizerCategory:
            return FertilizationLocalization.fertilizerCategoryOptions.count
        case fertilizer:
            return FertilizationLocalization.fertilizerOptions[fertilizerCategory.selectedRow(inComponent: 0)].count
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
            return FertilizationLocalization.fertilizerCategoryOptions[row]
        case fertilizer:
            return FertilizationLocalization.fertilizerOptions[fertilizerCategory.selectedRow(inComponent: 0)][row]
        default:
            return nil
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationFieldVerification.verify(field: field, self) else { return }
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
