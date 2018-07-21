//
//  AddDefoliationViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddDefoliationViewController: UIViewController {
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!

    var editIndex: Int?
    var source: DefoliationViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let editIndex = editIndex {
            let defoliation = source.defoliations[editIndex]

            date.date = defoliation.date
            field.text = defoliation.field
            user.text = defoliation.user
            workingHours.text = String(defoliation.workingHours)
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let field = OperationVerification.verify(field: field, self) else { return }
        guard let user = OperationVerification.verify(user: user, self) else { return }
        guard let workingHours = OperationVerification.verify(workingHours: workingHours, self) else { return }

        let defoliation = Defoliation(date: date.date,
                                      field: field,
                                      user: user,
                                      workingHours: workingHours)

        if let editIndex = editIndex {
            source.defoliations[editIndex] = defoliation
        } else {
            source.defoliations.append(defoliation)
        }

        source.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
