//
//  AddPlantProtectionViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddPlantProtectionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var appliedAmount: UITextField!
    @IBOutlet weak var plantProtectionKind: UITextField!
    @IBOutlet weak var pesticides: UITextField!
    @IBOutlet weak var treatmentSchedule: UIPickerView!
    @IBOutlet weak var additionalInformation: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantProtectionKind.delegate = self
        pesticides.delegate = self
        
        treatmentSchedule.delegate = self
        treatmentSchedule.dataSource = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Austrieb"
        case 1:
            return "Vorblüte"
        case 2:
            return "1. Vorblüte"
        case 3:
            return "2. Vorblüte"
        case 4:
            return "3. Vorblüte"
        case 5:
            return "Abgehende Blüte"
        case 6:
            return "2. Nachblüte"
        case 7:
            return "3. Nachblüte"
        default:
            return nil
        }
    }
    
    @IBAction func fungicidalClicked(_ sender: UIButton) {
    }
    
    @IBAction func herbicideClicked(_ sender: UIButton) {
    }
    
    @IBAction func insecticidalOrAcaricidalClicked(_ sender: UIButton) {
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
