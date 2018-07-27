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
            applyChanges(from: source.defoliations[editIndex])
        }
    }
    
    func applyChanges(from: Defoliation) {
        date.date = from.date
        field.text = from.field
        user.text = from.user
        workingHours.text = String(from.workingHours)
    }
    
    func applyChanges(to: Defoliation) {
        to.date = date.date
        to.field = field.text ?? ""
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationFieldVerification2.verify(field: field, self) else { return }
        guard OperationFieldVerification2.verify(user: user, self) else { return }
        guard OperationFieldVerification2.verify(workingHours: workingHours, self) else { return }
        
        do {
            if let editIndex = editIndex {
                let defoliation = source.defoliations[editIndex]
                
                try source.dataSource.update {
                    applyChanges(to: defoliation)
                }
            } else {
                let defoliation = Defoliation()
                applyChanges(to: defoliation)
                
                try source.dataSource.add(defoliation)
                source.defoliations.append(defoliation)
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
