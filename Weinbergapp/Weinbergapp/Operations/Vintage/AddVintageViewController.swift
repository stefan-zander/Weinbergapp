//
//  AddVintageViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
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
    var source: VintageTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        execution.delegate = self
        execution.dataSource = self
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
        let execution = self.execution.selectedRow(inComponent: 0) == 0 ?
            VintageExecution.Manual : VintageExecution.Mechanic
        
        if let editIndex = editIndex {
            source.vintages[editIndex].date = date.date
            source.vintages[editIndex].field = field.text!
            source.vintages[editIndex].user = user.text!
            source.vintages[editIndex].workingHours = Double(workingHours.text!)!
            source.vintages[editIndex].execution = execution
            
        } else {
            let vintage = Vintage(date: date.date, field: field.text!, user: user.text!, workingHours: Double(workingHours.text!)!, execution: execution)
            
            source.vintages.append(vintage)
        }
        
        source.tableView.reloadData()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
}
