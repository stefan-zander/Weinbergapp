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
        guard let field = field.text, !field.isEmpty else {
            let alert = UIAlertController(title: "Feld nicht angegeben", message: "Das Feld darf nicht leer sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let user = user.text, !user.isEmpty else {
            let alert = UIAlertController(title: "Benutzer nicht angegeben", message: "Der Benuzter darf nicht leer sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let workingHoursText = workingHours.text, !workingHoursText.isEmpty else {
            let alert = UIAlertController(title: "Arbeitsstunden nicht angegeben", message: "Die Arbeitsstunden müssen angegeben sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let workingHours = Double(workingHoursText) else {
            let alert = UIAlertController(title: "Arbeitsstunden ist keine Zahl", message: "Bei der Angabe von Arbeitsstunden sind nur Zahlen zugelassen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
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
