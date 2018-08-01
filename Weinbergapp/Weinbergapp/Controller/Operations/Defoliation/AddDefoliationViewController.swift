//
//  AddDefoliationViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddDefoliationViewController: UIViewController {

    public var onLoad: (() -> Void)?
    public var onSave: (() -> Bool)?

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UIPickerView!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    
    var fields: [Field]!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let onLoad = onLoad {
            onLoad()
        }
    }

    public func applyChanges(from: Defoliation) {
        date.date = from.date
        
        if let index = fields.index(of: from.field!) {
            field.selectRow(index, inComponent: 0, animated: false)
        }
        
        user.text = from.user
        workingHours.text = String(from.workingHours)
    }

    public func applyChanges(to: Defoliation) {
        to.date = date.date
        to.field = fields[field.selectedRow(inComponent: 0)]
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationFieldVerification.verify(user: user, self) else { return }
        guard OperationFieldVerification.verify(workingHours: workingHours, self) else { return }

        if let onSave = onSave {
            guard onSave() else { return }
        }

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
