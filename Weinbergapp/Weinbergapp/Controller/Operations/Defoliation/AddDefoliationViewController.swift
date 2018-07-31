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
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let onLoad = onLoad {
            onLoad()
        }
    }

    public func applyChanges(from: Defoliation) {
        date.date = from.date
        field.text = from.field
        user.text = from.user
        workingHours.text = String(from.workingHours)
    }

    public func applyChanges(to: Defoliation) {
        to.date = date.date
        to.field = field.text ?? ""
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationFieldVerification.verify(field: field, self) else { return }
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
