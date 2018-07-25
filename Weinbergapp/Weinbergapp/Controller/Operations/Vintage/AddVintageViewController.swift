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
            let vintage = source.vintages[editIndex]

            date.date = vintage.date
            field.text = vintage.field
            user.text = vintage.user
            workingHours.text = String(vintage.workingHours)
            execution.selectRow(vintage.execution.rawValue, inComponent: 0, animated: true)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Händisch"
        case 1:
            return "Mechanisch"
        default:
            return nil
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let field = OperationFieldVerification.verify(field: field, self) else { return }
        guard let user = OperationFieldVerification.verify(user: user, self) else { return }
        guard let workingHours = OperationFieldVerification.verify(workingHours: workingHours, self) else { return }

        guard let execution = VintageExecution(rawValue: execution.selectedRow(inComponent: 0)) else {
            assert(false)
            return
        }

        let vintage = Vintage(date: date.date,
                              field: field,
                              user: user,
                              workingHours: workingHours,
                              execution: execution)

        if let editIndex = editIndex {
            source.vintages[editIndex] = vintage
        } else {
            source.vintages.append(vintage)
        }

        source.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
