//
//  AddVintageViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddVintageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var execution: UIPickerView!

    var editIndex: Int?
    var source: VintageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        execution.delegate = self
        execution.dataSource = self

        if let editIndex = editIndex {
            applyChanges(from: source.vintages[editIndex])
        }
    }
    
    func applyChanges(from: Vintage) {
        date.date = from.date
        field.text = from.field
        user.text = from.user
        workingHours.text = String(from.workingHours)
        execution.selectRow(from.executionRaw, inComponent: 0, animated: false)
    }
    
    func applyChanges(to: Vintage) {
        to.date = date.date
        to.field = field.text ?? ""
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
        to.executionRaw = execution.selectedRow(inComponent: 0)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return VintageLocalization.getExecution(index: row)
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationFieldVerification.verify(field: field, self) else { return }
        guard OperationFieldVerification.verify(user: user, self) else { return }
        guard OperationFieldVerification.verify(workingHours: workingHours, self) else { return }

        do {
            if let editIndex = editIndex {
                let vintage = source.vintages[editIndex]
                
                try source.dataSource.update {
                    applyChanges(to: vintage)
                }
            } else {
                let vintage = Vintage()
                applyChanges(to: vintage)
                
                try source.dataSource.add(vintage)
                source.vintages.append(vintage)
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
