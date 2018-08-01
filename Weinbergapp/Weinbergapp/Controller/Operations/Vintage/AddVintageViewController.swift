//
//  AddVintageViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddVintageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    public var onLoad: (() -> Void)?
    public var onSave: (() -> Bool)?

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UIPickerView!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var execution: UIPickerView!
    
    var fields: FieldCollection!

    override func viewDidLoad() {
        super.viewDidLoad()

        field.delegate = self
        field.dataSource = self
        execution.delegate = self
        execution.dataSource = self

        if let onLoad = onLoad {
            onLoad()
        }
    }

    func applyChanges(from: Vintage) {
        date.date = from.date
        
        if let index = fields.index(of: from.field!) {
            field.selectRow(index, inComponent: 0, animated: false)
        }
        
        user.text = from.user
        workingHours.text = String(from.workingHours)
        execution.selectRow(from.executionRaw, inComponent: 0, animated: false)
    }

    func applyChanges(to: Vintage) {
        to.date = date.date
        to.field = fields[field.selectedRow(inComponent: 0)]
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
        to.executionRaw = execution.selectedRow(inComponent: 0)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case field:
            return fields.count
        case execution:
            return VintageLocalization.executionOptions.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case field:
            return fields[row].name
        case execution:
            return VintageLocalization.executionOptions[row]
        default:
            return nil
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationDialogs.verifyOrPresent(user: user, self) else { return }
        guard OperationDialogs.verifyOrPresent(workingHours: workingHours, self) else { return }

        if let onSave = onSave {
            guard onSave() else { return }
        }

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
